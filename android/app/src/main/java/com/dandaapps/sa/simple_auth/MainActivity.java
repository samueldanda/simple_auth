package com.dandaapps.sa.simple_auth;

import android.content.ContentResolver;
import android.provider.Settings;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "developer_options";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        new MethodChannel.MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                                if (call.method.equals("isDeveloperOptionsEnabled")) {
                                    boolean isEnabled = isDeveloperOptionsEnabled();
                                    result.success(isEnabled);
                                } else {
                                    result.notImplemented();
                                }
                            }
                        }
                );
    }

    private boolean isDeveloperOptionsEnabled() {
        ContentResolver contentResolver = getContentResolver();
        try {
            int devOptions = Settings.Secure.getInt(contentResolver, Settings.Secure.DEVELOPMENT_SETTINGS_ENABLED);
            return devOptions == 1;
        } catch (Settings.SettingNotFoundException e) {
            return false;
        }
    }
}
