package com.gdgnashik.facebook_login;


import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// Created by VIvek on 2019-09-03.
public class HashKey {
    static void getKey(Context context) {
        try {
            PackageInfo info = context.getPackageManager().getPackageInfo("com.gdgnashik.facebook_login",
                    PackageManager.GET_SIGNATURES);
            for (Signature signature : info.signatures) {
                MessageDigest md = MessageDigest.getInstance("SHA");
                md.update(signature.toByteArray());
                String sign = Base64.encodeToString(md.digest(), Base64.DEFAULT);
                Log.e("MY KEY HASH:", sign);
                Toast.makeText(context, sign, Toast.LENGTH_LONG).show();
            }
        } catch (PackageManager.NameNotFoundException e) {
            Log.e("tag",e.toString());

        } catch (NoSuchAlgorithmException e) {
            Log.e("tag",e.toString());
        }
    }
}
