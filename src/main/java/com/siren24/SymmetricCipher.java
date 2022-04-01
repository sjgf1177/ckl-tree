package com.siren24;

// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SymmetricCipher.java

import java.io.PrintStream;
import java.security.SecureRandom;

public class SymmetricCipher
{

    public SymmetricCipher()
    {
    }

    public static byte[] SEED_CBC_ENCRYPT(byte encryptStr[], byte key[])
    {
        byte encryptText[] = (byte[])null;
        try
        {
            byte plainText[] = encryptStr;
            BlockCipher blockCipher = new SEED();
            blockCipher.engineSetMode("CBC");
            blockCipher.engineSetPadding("PKCS5Padding");
            int length = key.length;
            for(int i = 0; i < length; i++)
                key[i] ^= key[length - i - 1];

            blockCipher.engineInit(1, key, new SecureRandom());
            encryptText = blockCipher.engineDoFinal(plainText, 0, plainText.length);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return encryptText;
    }

    public static byte[] SEED_CBC_DECRYPT(byte decryptBytes[], byte key[])
    {
        byte plainText[] = (byte[])null;
        try
        {
            byte encryptText[] = decryptBytes;
            BlockCipher blockCipher = new SEED();
            blockCipher.engineSetMode("CBC");
            blockCipher.engineSetPadding("PKCS5Padding");
            int length = key.length;
            for(int i = 0; i < length; i++)
                key[i] ^= key[length - i - 1];

            blockCipher.engineInit(2, key, new SecureRandom());
            plainText = blockCipher.engineDoFinal(encryptText, 0, encryptText.length);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return plainText;
    }

    public static byte[] SEED_ECB_ENCRYPT(byte encryptStr[])
    {
        byte encryptText[] = (byte[])null;
        try
        {
            byte plainText[] = encryptStr;
            BlockCipher blockCipher = new SEED();
            blockCipher.engineSetMode("ECB");
            blockCipher.engineSetPadding("PKCS5Padding");
            byte key[] = new byte[16];
            key = blockCipher.getKey();
            blockCipher.engineInit(1, key, new SecureRandom());
            debug("The inputed Message(hexadecimal): ", plainText);
            encryptText = blockCipher.engineDoFinal(plainText, 0, plainText.length);
            debug("The Encrypted message(hexadecimal): ", encryptText);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return encryptText;
    }

    public static byte[] SEED_ECB_DECRYPT(byte decryptBytes[])
    {
        byte plainText[] = (byte[])null;
        try
        {
            byte encryptText[] = decryptBytes;
            BlockCipher blockCipher = new SEED();
            blockCipher.engineSetMode("ECB");
            blockCipher.engineSetPadding("PKCS5Padding");
            byte key[] = new byte[16];
            key = blockCipher.getKey();
            blockCipher.engineInit(2, key, new SecureRandom());
            debug("The inputed Message(hexadecimal): ", encryptText);
            plainText = blockCipher.engineDoFinal(encryptText, 0, encryptText.length);
            debug("The Decrypted message: ", plainText);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return plainText;
    }

    protected static void debug(String msg, byte bytes[])
    {
        System.out.print(msg);
        for(int i = 0; i < bytes.length; i++)
            if(bytes[i] > 15 || bytes[i] < 0)
                System.out.print(Integer.toHexString(bytes[i] & 0xff) + " ");
            else
                System.out.print("0" + Integer.toHexString(bytes[i] & 0xff) + " ");

        System.out.println(" ");
    }
}
