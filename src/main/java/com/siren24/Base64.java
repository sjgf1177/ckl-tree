package com.siren24;

// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Base64.java


public class Base64
{

    public Base64()
    {
    }

    public static final String base64Encode(String str)
    {
        if(str == null)
        {
            return null;
        } else
        {
            byte data[] = str.getBytes();
            return new String(base64Encode(data));
        }
    }

    public static final byte[] base64Encode(byte data[])
    {
        if(data == null)
            return null;
        byte dest[] = new byte[((data.length + 2) / 3) * 4];
        int sidx = 0;
        int didx = 0;
        for(; sidx < data.length - 2; sidx += 3)
        {
            dest[didx++] = Base64EncMap[data[sidx] >>> 2 & 0x3f];
            dest[didx++] = Base64EncMap[data[sidx + 1] >>> 4 & 0xf | data[sidx] << 4 & 0x3f];
            dest[didx++] = Base64EncMap[data[sidx + 2] >>> 6 & 3 | data[sidx + 1] << 2 & 0x3f];
            dest[didx++] = Base64EncMap[data[sidx + 2] & 0x3f];
        }

        if(sidx < data.length)
        {
            dest[didx++] = Base64EncMap[data[sidx] >>> 2 & 0x3f];
            if(sidx < data.length - 1)
            {
                dest[didx++] = Base64EncMap[data[sidx + 1] >>> 4 & 0xf | data[sidx] << 4 & 0x3f];
                dest[didx++] = Base64EncMap[data[sidx + 1] << 2 & 0x3f];
            } else
            {
                dest[didx++] = Base64EncMap[data[sidx] << 4 & 0x3f];
            }
        }
        for(; didx < dest.length; didx++)
            dest[didx] = 61;

        return dest;
    }

    public static final String base64Decode(String str)
    {
        if(str == null)
        {
            return null;
        } else
        {
            byte data[] = str.getBytes();
            return new String(base64Decode(data));
        }
    }

    public static final byte[] base64Decode(byte data[])
    {
        if(data == null)
            return null;
        int tail;
        for(tail = data.length; data[tail - 1] == 61; tail--);
        byte dest[] = new byte[tail - data.length / 4];
        for(int idx = 0; idx < data.length; idx++)
            data[idx] = Base64DecMap[data[idx]];

        int sidx = 0;
        int didx;
        for(didx = 0; didx < dest.length - 2; didx += 3)
        {
            dest[didx] = (byte)(data[sidx] << 2 & 0xff | data[sidx + 1] >>> 4 & 3);
            dest[didx + 1] = (byte)(data[sidx + 1] << 4 & 0xff | data[sidx + 2] >>> 2 & 0xf);
            dest[didx + 2] = (byte)(data[sidx + 2] << 6 & 0xff | data[sidx + 3] & 0x3f);
            sidx += 4;
        }

        if(didx < dest.length)
            dest[didx] = (byte)(data[sidx] << 2 & 0xff | data[sidx + 1] >>> 4 & 3);
        if(++didx < dest.length)
            dest[didx] = (byte)(data[sidx + 1] << 4 & 0xff | data[sidx + 2] >>> 2 & 0xf);
        return dest;
    }

    private static byte Base64EncMap[];
    private static byte Base64DecMap[];

    static 
    {
        byte map[] = {
            65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 
            75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 
            85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 
            101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 
            111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 
            121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 
            56, 57, 43, 47
        };
        Base64EncMap = map;
        Base64DecMap = new byte[128];
        for(int idx = 0; idx < Base64EncMap.length; idx++)
            Base64DecMap[Base64EncMap[idx]] = (byte)idx;

    }
}
