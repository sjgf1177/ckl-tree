package com.icross.core.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64Util
{
  public static String decryptBase64(String securedValue)
    throws Exception
  {
    byte[] decryptedBytes = base64Decode(securedValue);
    String decryptedValue = new String(decryptedBytes);
    return decryptedValue;
  }

  public static String base64Encode(byte[] data) throws Exception
  {
    BASE64Encoder encoder = new BASE64Encoder();
    String encoded = encoder.encode(data);
    return encoded;
  }

  public static byte[] base64Decode(String encryptedData) throws Exception
  {
    BASE64Decoder decoder = new BASE64Decoder();
    byte[] decoded = decoder.decodeBuffer(encryptedData);
    return decoded;
  }
}