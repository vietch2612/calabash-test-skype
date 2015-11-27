# Automation Test cho Android app sử dụng Calabash-Cucumber
## Cài đặt Android SDK. 
Tải và cài đặt Android SDK dành cho Mac OS tại [Android SDK Stand alone download](http://developer.android.com/sdk/index.html#Other)
    ![android_sdk_for_macos](http://i.imgur.com/sm5eCyE.png)  
    
Sau khi tải về máy và giải nén, chúng ta phải cấu hình biến môi trường <code>ANDROID_HOME</code> và <code>PATH</code> với 2 folder <code>platform-tools</code> và <code>tools</code> trong folder của Android SDK  
Cài đặt <code>ANDROID_HOME</code> bằng cách gõ command vào terminal  
```bash
export ANDROID_HOME=/path/to/your/android/sdk/folder
```
<code>/path/to/your/android/sdk/folder</code> là đường dẫn tới folder lưu SDK của bạn, chẳng hạn như của mình sẽ là <code>/User/hoaiviet/Documents/android-sdk</code>  
  
Và cài đặt `PATH`:
```bash
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

## Cài đặt Ruby.  
Đầu tiên là máy Mac của bạn phải có `Homebrew`, nếu chưa có thì bạn phải cài đặt trước khi cài đặt Ruby.  
```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
  
Tiếp theo là cài đặt Ruby, các bạn hãy làm theo các bước như bên dưới  
  
```bash
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

Nếu kiểm tra `ruby -v` không đúng với version 2.2.3 thì các bạn hãy paste những đoạn sau vào cuối file `~/.bash_profile`
```bash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

## Cài đặt gem calabash-android.
Sau khi đã cài đặt xong Ruby thì chúng ta cần cài đặt gem Calabash-Android
```bash
gem install calabash-android
```

## Khởi tạo thư mục test
Cáo thứ các bạn cần chuẩn bị là:  
* Device android hoặc Emulator  
* File APK của app bạn muốn test.  
* Sublime Text hoặc bất kì một công cụ Texit Editor nào đó.  
  
Trong bài này mình sẽ sử dụng là app Skype

Bây giờ bắt đầu tạo 1 folder mới
```bash
mkdir calabsah-test-skype
```

Mở folder vừa tạo
```bash
cd calabash-test-skype
```

Tiếp theo chúng ta sẽ tạo generate ra folder test bằng command
```bash
calabash-android gen
```
Calabash sẽ yêu cầu bạn nhấn Enter để tiếp tục, hãy nhấn Enter và bạn sẽ nhận được folder dạng như sau: 

![folder_structer](http://i.imgur.com/Ltl5gtd.png)

Ở đây các bạn cần quan tâm nhất 2 phần:  
`step_definitions`: Sẽ chứa các file ruby mà các bạn sẽ định nghĩa các bước, ví dụ như nhấn button nào, gõ dòng text gì.

Các file có đuôi `.feature` là những file mình sẽ viết Scenario, Test cases của app.

Bước tiếp theo, hãy copy file APK của app mình muốn test vào folder vừa tạo, sao đó resign app:
```bash
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

```cucumber
Feature: Login feature

  Scenario: As a valid user I can log into my app
    Given I press the "Skype Name" button
    Given I enter "viet.ch2612" into input field number 1
    Given I enter my secret password into input fiend number 2
    When I press image view with id "sign_in_btn"
    Then I should see "Add friend"
```

Bước cuối cùng là run test. Để chạy được trên devices thật thì các bạn nhớ cắm dây USB và bật USB Debugging lên nhé.
Tốt nhất các bạn nên kiểm tra bằng câu lệnh
```bash
adb devices
```

OK bây giờ chúng ta hãy run thử
```bash
calabash-android run skype.apk
```
Hãy xem devices và kết quả 
![first_run](http://i.imgur.com/LuvPgK4.png)

Ồ, bước 1,2 chúng ta đã chạy OK nhưng tới bước 3 thì calabash báo là chúng ta chưa định nghĩa step này. OK giờ chúng ta sẽ định nghĩa nó. Trong folder test, chúng ta hãy mở file `calabash_steps.rb` trong folder `step_definitions` và thêm hàm như sau để định nghĩa step trên

```ruby
Given(/^I enter my secret password into input fiend number (\d+)$/) do |index|
  enter_text("android.widget.EditText index:#{index.to_i-1}", "password")
end
```

Và bây giờ chúng ta run test lại lần nữa:

`kết quả`

## Test report?
Các bạn sẽ tự hỏi, tất cả thông báo các steps pass và fail đều hiện lên trên command line như vậy thì lưu lại report kiểu gì phải không? Tất nhiên là Calabash có hỗ trợ lưu report dưới dạng file, và cụ thể là HTML và report cũng rất là "cool". 
```bash
calabash-android run skype.apk --format html --out <filename>.html
```
hoặc
```bash
calabash-android run skype.apk -f html -o <filename>.html
```

## Run cụ thể một feature nào đó?
Đơn giản là bạn chỉ cần dẫn tới file feature đó là được
```bash
calabash-android run skype.apk feature/<filename>.feature
```

## Run cụ thể một @tag nào đó?
```bash
calabash-android run skype.apk --tag @test
```
hoặc
```bash
calabash-android run skype.apk -t @test
```

## Reset (Clear app data) với tag @reset
Các bạn chỉ cần thêm đoạn code sau vào file `feature/support/app_installation_hooks.rb` bên trong `Before`
```ruby
scenario_tags = scenario.source_tag_names
  if scenario_tags.include?("@reset")
    clear_app_data
  end
```

Còn tại feature, chúng ta chỉ cần thêm tag @reset vào trước Scenario để clear app data
```cucumber
@reset
  Scenario: As a valid user I can log into my app
    Given I press the "Skype Name" button
```




