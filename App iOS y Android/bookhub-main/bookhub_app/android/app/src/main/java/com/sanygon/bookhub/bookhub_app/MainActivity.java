package com.sanygon.bookhub.bookhub_app;

import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import android.widget.VideoView;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        final VideoView videoView = findViewById(R.id.video_splash);
        Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.logo_splash);
        videoView.setVideoURI(video);

        videoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer mp) {

                DisplayMetrics displayMetrics = new DisplayMetrics();
                getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
                int screenWidth = displayMetrics.widthPixels;
                int screenHeight = displayMetrics.heightPixels;

                ViewGroup.LayoutParams params = videoView.getLayoutParams();
                params.width = screenWidth;
                params.height = screenHeight;
                videoView.setLayoutParams(params);

                videoView.start();
            }
        });

        videoView.setOnCompletionListener(mp -> startFlutterActivity());
    }

    private void startFlutterActivity() {
        Intent intent = new Intent(this, FlutterActivity.class);
        startActivity(intent);
        finish();
    }
}
