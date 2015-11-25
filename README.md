# Automation Test cho Android app sử dụng Calabash-Cucumber
## Cài đặt Android SDK. 
Tải và cài đặt Android SDK dành cho Mac OS tại [Android SDK Stand alone download](http://developer.android.com/sdk/index.html#Other)
    ![android_sdk_for_macos](http://i.imgur.com/sm5eCyE.png)  
    
Sau khi tải về máy và giải nén, chúng ta phải cấu hình biến môi trường <code>ANDROID_HOME</code> và <code>PATH</code> với 2 folder <code>platform-tools</code> và <code>tools</code> trong folder của Android SDK  
Cài đặt <code>ANDROID_HOME</code> bằng cách gõ command vào terminal  
<pre><code>export ANDROID_HOME=/path/to/your/android/sdk/folder</code></pre>  
<code>/path/to/your/android/sdk/folder</code> là đường dẫn tới folder lưu SDK của bạn, chẳng hạn như của mình sẽ là <code>/User/hoaiviet/Documents/android-sdk</code>  
  
Và cài đặt `PATH`:
```
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

## Cài đặt Ruby.  
Đầu tiên là máy Mac của bạn phải có `Homebrew`, nếu chưa có thì bạn phải cài đặt trước khi cài đặt Ruby.  
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
  
Tiếp theo là cài đặt Ruby, các bạn hãy làm theo các bước như bên dưới  
  
```
brew install rbenv ruby-build

# Bước này để rbenv được load mỗi khi bạn mở terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Cài đặt ruby
rbenv install 2.2.3
rbenv global 2.2.3

# Kiểm tra 
ruby -v
```

## Cài đặt gem calabash-android.
Sau khi đã cài đặt xong Ruby thì chúng ta cần cài đặt gem Calabash-Android
```
gem install calabash-android
```

## Khởi tạo thư mục test
Cáo thứ các bạn cần chuẩn bị là:  
* Device android hoặc Emulator  
* File APK của app bạn muốn test.  
* Sublime Text hoặc bất kì một công cụ Texit Editor nào đó.  
  
Trong bài này mình sẽ sử dụng là app Skype

Bây giờ bắt đầu tạo 1 folder mới
```
mkdir calabsah-test-skype
```

Mở folder vừa tạo
```
cd calabash-test-skype
```

Tiếp theo chúng ta sẽ tạo generate ra folder test bằng command
```
calabash-android gen
```
Calabash sẽ yêu cầu bạn nhấn Enter để tiếp tục, hãy nhấn Enter và bạn sẽ nhận được folder dạng như sau: 

![folder_structer](http://i.imgur.com/Ltl5gtd.png)

Ở đây các bạn cần quan tâm nhất 2 phần:  
`step_definitions`: Sẽ chứa các file ruby mà các bạn sẽ định nghĩa các bước, ví dụ như nhấn button nào, gõ dòng text gì.

Các file có đuôi `.feature` là những file mình sẽ viết Scenario, Test cases của app.

Bước tiếp theo, hãy copy file APK của app mình muốn test vào folder vừa tạo, sao đó resign app:
```
calabash-android resign skype.apk
```

## Viết scenario đầu tiên
Bắt đầu chúng ta hãy mở file `my_fist.feature` bằng Sublime Text, chúng ta sẽ thấy như hình 

![first_step](http://i.imgur.com/verAlLs.png)

Đọc đến đây chắc các bạn cũng tự hỏi, làm sao để biết được viết các steps như nào mới là đúng? OK, tất cả các Steps mà Calabash đã defined sẵn ở đây, các bạn có thể xem ở đây: [canned_steps](https://github.com/calabash/calabash-android/blob/master/ruby-gem/lib/calabash-android/canned_steps.md)

Nào quay lại với file feature, chúng ta hãy định nghĩa 1 scenario đơn giản cho chức năng đăng nhập bằng Skype name

```
Step 1: Nhấn button Skype Name
Step 2: Điền tài khoản skype vào khung nhập thứ nhất
Step 3: Điền mật khẩu vào khung nhập thứ hai
Step 4: Nhấn button đăng nhập
Step 5: Kết quả mong muốn là muốn thấy nút Add friends
```

Xong rồi, chúng ta bắt đầu sửa file `my_first.feature` theo các step chúng ta đã define ở trên:

```
Feature: Login feature

  Scenario: As a valid user I can log into my app
    Given I press the "Skype Name" button
    Given I enter "viet.ch2612" into input field number 1
    Given I enter my secret password into input fiend number 2
    When I press image button number 1
    Then I should see "Add friend"
```

Bước cuối cùng là run test. Để chạy được trên devices thật thì các bạn nhớ cắm dây USB và bật USB Debugging lên nhé.
Tốt nhất các bạn nên kiểm tra bằng câu lệnh
```
adb devices
```

OK bây giờ chúng ta hãy run thử
```
calabash-android run skype.apk
```
Hãy xem devices và kết quả 
![first_run](http://i.imgur.com/LuvPgK4.png)

Ồ, bước 1,2 chúng ta đã chạy OK nhưng tới bước thì calabash báo là chúng ta chưa định nghĩa step này. OK giờ chúng ta sẽ định nghĩa nó. Trong folder test, chúng ta hãy mở file `calabash_steps.rb` trong folder `step_definitions` và thêm hàm như sau

```
Given(/^I enter my secret password into input fiend number (\d+)$/) do |arg1|
  enter_text("android.widget.EditText index:#{index.to_i-1}", "password")
end
```

Và bây giờ chúng ta run test lại lần nữa:


