package com.example.surf_practice_chat_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("6a5ebebd-95ea-4b17-a3ca-4df8832582c2")
        MapKitFactory.setLocale("ru")
        super.configureFlutterEngine(flutterEngine)
    }
}