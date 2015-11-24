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

Đọc đến đây chắc các bạn cũng tự hỏi, làm sao để biết được viết các steps như nào mới là đúng? OK, tất cả các Steps mà Calabash đã defined sẵn ở đây, các bạn có thể dùng https://github.com/calabash/calabash-android/blob/master/ruby-gem/lib/calabash-android/canned_steps.md

Nào quay lại với file feature, chúng ta hãy thử viết theo như bên dưới

```
//demo
```

## Run
Xong rồi, chúng ta bắt đầu run thôi.

```
calabash-android run skype.apk
```


