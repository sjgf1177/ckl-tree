package com.icross.core.module.crypto;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.security.Key;
import javax.crypto.Cipher;
import javax.crypto.CipherOutputStream;
import org.apache.commons.codec.binary.Base64;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;

public class TripleDESCrypto
{
  private static String keyFile =   EgovProperties.getProperty("Globals.webRootPath") + "/WEB-INF/config/common-secret.key";

  private static String algorithm = "DESede/ECB/PKCS5Padding";
  private InputStream defaultInputStream = null;

  private TripleDESCrypto() {
    this.defaultInputStream = getClass().getResourceAsStream(keyFile);

    if (this.defaultInputStream == null)
      this.defaultInputStream = getClass().getResourceAsStream(keyFile);
  }

  private static Key getKey(String keyFile)
    throws Exception
  {
    String fileURL = null;
    ObjectInputStream in = null;

    if (keyFile == null) {
      in = new ObjectInputStream(new TripleDESCrypto().defaultInputStream);
    } else {
      fileURL = keyFile;
      in = new ObjectInputStream(new FileInputStream(EgovWebUtil.filePathBlackList(fileURL)));
    }

    Key key = (Key)in.readObject();
    in.close();

    return key;
  }

  public static String encrypt(String ID, String keyFile)
    throws Exception
  {
    if ((ID == null) || (ID.length() == 0)) {
      return "";
    }
    Cipher cipher = Cipher.getInstance(algorithm);
    cipher.init(1, getKey(keyFile));
    String amalgam = ID;

    byte[] inputBytes1 = amalgam.getBytes();
    byte[] outputBytes1 = cipher.doFinal(inputBytes1);

    return new String(Base64.encodeBase64(outputBytes1));
  }

  public static String encrypt(String ID) throws Exception
  {
    return encrypt(ID, keyFile);
  }

  public static String decrypt(String codedID, String keyFile)
    throws Exception
  {
    if ((codedID == null) || (codedID.length() == 0)) {
      return "";
    }
    Cipher cipher = Cipher.getInstance(algorithm);
    cipher.init(2, getKey(keyFile));

    byte[] decryptedBytes = cipher.doFinal(Base64.decodeBase64(codedID.getBytes()));

    return new String(decryptedBytes);
  }

  public static String decrypt(String codedID) throws Exception
  {
    return decrypt(codedID, keyFile);
  }

  public static void encryptFile(String infile, String outfile, String keyFile)
    throws Exception
  {
    Cipher cipher = Cipher.getInstance(algorithm);
    cipher.init(1, getKey(keyFile));

    FileInputStream in = new FileInputStream(EgovWebUtil.filePathBlackList(infile));
    FileOutputStream fileOut = new FileOutputStream(EgovWebUtil.filePathBlackList(outfile));

    CipherOutputStream out = new CipherOutputStream(fileOut, cipher);
    byte[] buffer = new byte[8192];
    int length;
    while ((length = in.read(buffer)) != -1)
    {
      out.write(buffer, 0, length);
    }
    in.close();
    out.close();
  }

  public static void encryptFile(String infile, String outfile) throws Exception
  {
    encryptFile(infile, outfile, null);
  }

  public static void decryptFile(String infile, String outfile, String keyFile)
    throws Exception
  {
    Cipher cipher = Cipher.getInstance(algorithm);
    cipher.init(2, getKey(keyFile));

    FileInputStream in = new FileInputStream(EgovWebUtil.filePathBlackList(infile));
    FileOutputStream fileOut = new FileOutputStream(EgovWebUtil.filePathBlackList(outfile));

    CipherOutputStream out = new CipherOutputStream(fileOut, cipher);
    byte[] buffer = new byte[8192];
    int length;
    while ((length = in.read(buffer)) != -1)
    {
      out.write(buffer, 0, length);
    }
    in.close();
    out.close();
  }

  public static void decryptFile(String infile, String outfile)
    throws Exception
  {
    decryptFile(infile, outfile, null);
  }

  public static void main(String[] ars) throws Exception
  {
    if (ars.length < 2) {
      System.out.println("USE : DESCrypto [-d | -e | -fd | -fe] [text | inputfilename outputfilename]");
      System.exit(0);
    }
    if (ars[0].equals("-d")) {
      System.out.println(decrypt(ars[1]));
    }
    if (ars[0].equals("-e")) {
      System.out.println(encrypt(ars[1]));
    }
    if (ars[0].equals("-fd")) {
      decryptFile(ars[1], ars[2]);
    }
    if (ars[0].equals("-fe"))
      encryptFile(ars[1], ars[2]);
  }
}