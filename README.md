# Hướng dẫn viết Automation Test cho Android app sử dụng Calabash-Cucumber
------

## Cài đặt Android SDK. 
Tải và cài đặt Android SDK dành cho Mac OS tại [Android SDK Stand alone download](http://developer.android.com/sdk/index.html#Other)
    ![android_sdk_for_macos](http://i.imgur.com/sm5eCyE.png)
Sau khi tải về máy và giải nén, chúng ta phải cấu hình biến môi trường <code>ANDROID_HOME</code> và <code>PATH</code> với 2 folder <code>platform-tools</code> và <code>tools</code> trong folder của Android SDK
Cài đặt <code>ANDROID_HOME</code> bằng cách gõ command vào terminal
<pre><code>export ANDROID_HOME=/path/to/your/android/sdk/folder</code></pre>
<code>/path/to/your/android/sdk/folder</code> là đường dẫn tới folder lưu SDK của bạn, chẳng hạn như của mình sẽ là <code>/User/hoaiviet/Documents/android-sdk</code>
Và cài đặt <code>PATH</code>:
<pre><code>export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools</pre></code>
	
2. Cài đặt Ruby.  
3. Cài đặt gem calabash-android.
