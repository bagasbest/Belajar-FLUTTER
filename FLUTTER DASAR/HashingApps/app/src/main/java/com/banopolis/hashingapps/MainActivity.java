package com.banopolis.hashingapps;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.Editable;
import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.math.BigInteger;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class MainActivity extends AppCompatActivity {

    EditText inputText;
    TextView outputText;
    Button encBtn;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        inputText = findViewById(R.id.inputText);
        outputText = findViewById(R.id.outputText);
        encBtn = findViewById(R.id.btnEnc);


        encBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                byte [] inputDtat = inputText.getText().toString().getBytes();
                byte [] outputData = new byte[0];

                try {
                    outputData = sha.encryptSHA(inputDtat, "SHA-256");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                BigInteger shaData = new BigInteger(1, outputData);
                outputText.setText(shaData.toString(16));

            }
        });



    }


}
