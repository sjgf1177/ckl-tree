/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.

package kr.co.unp.util;


public class UuidUtils
{

    public UuidUtils()
    {
    }

    public static synchronized long generateOne()
    {
        long time = System.currentTimeMillis();
        if(time <= lastTime)
            time = lastTime + 1L;
        lastTime = time;
        return 1426063360L | time;
    }

    public static boolean isValid(long uuid)
    {
        return (uuid & -16777216L) == 1426063360L && (uuid & 16777215L) != 0L;
    }

    public static final long UUID_NONE = 0L;
    public static final long UUID_WILD = -1L;
    public static final long UUID_MAGICMASK = -16777216L;
    public static final long UUID_MAGIC = 1426063360L;
    protected static long lastTime;
}


/*
	DECOMPILATION REPORT

	Decompiled from: S:\workspace-jongno\workspace\tirePro_200\WebContent\WEB-INF\lib\redshop3.5.jar
	Total time: 63 ms
	Jad reported messages/errors:
	Exit status: 0
	Caught exceptions:
*/