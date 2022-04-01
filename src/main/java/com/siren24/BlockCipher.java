package com.siren24;

// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   BlockCipher.java

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.ShortBufferException;

public abstract class BlockCipher
{
    protected class PKCS5Padding extends Padding
    {

        protected boolean doPadding()
        {
            int extra = inputBufferOffset == 0 ? blockSize : blockSize - inputBufferOffset;
            for(int i = 0; i < extra; i++)
                inputBuffer[inputBufferOffset + i] = (byte)extra;

            return true;
        }

        protected int doUnPadding(byte buffer[])
            throws BadPaddingException
        {
            int numPad = buffer[buffer.length - 1];
            if(numPad < 1 || numPad > blockSize)
                throw new BadPaddingException("Weird number of padding bytes: " + numPad + " detected" + blockSize);
            else
                return blockSize - numPad;
        }

        protected PKCS5Padding()
        {
        }
    }

    protected class Padding
    {

        protected boolean doPadding()
            throws IllegalBlockSizeException
        {
            if(inputBufferOffset != 0)
                throw new IllegalBlockSizeException("Needs padding");
            else
                return false;
        }

        protected int doUnPadding(byte buffer[])
            throws BadPaddingException
        {
            return blockSize;
        }

        protected Padding()
        {
        }
    }

    protected class Zeroes extends Padding
    {

        protected boolean doPadding()
            throws IllegalBlockSizeException
        {
            if(inputBufferOffset == 0)
                return false;
            int extra = inputBufferOffset == 0 ? 0 : blockSize - inputBufferOffset;
            for(int i = 0; i < extra; i++)
                inputBuffer[inputBufferOffset + i] = 0;

            return true;
        }

        protected Zeroes()
        {
        }
    }


    protected BlockCipher()
    {
        this(16);
    }

    protected BlockCipher(int blockSize)
    {
        state = 0;
        mode = 0;
        pad = new PKCS5Padding();
        paddingType = 1;
        IV = null;
        key = null;
        needIV = false;
        this.blockSize = blockSize;
        key = new byte[16];
        key[0] = Byte.parseByte("24", 16);
        key[1] = Byte.parseByte("3f", 16);
        key[2] = Byte.parseByte("12", 16);
        key[3] = Byte.parseByte("72", 16);
        key[4] = Byte.parseByte("59", 16);
        key[5] = Byte.parseByte("28", 16);
        key[6] = Byte.parseByte("1d", 16);
        key[7] = Byte.parseByte("2b", 16);
        key[8] = Byte.parseByte("51", 16);
        key[9] = Byte.parseByte("74", 16);
        key[10] = Byte.parseByte("3f", 16);
        key[11] = Byte.parseByte("1a", 16);
        key[12] = Byte.parseByte("3e", 16);
        key[13] = Byte.parseByte("62", 16);
        key[14] = Byte.parseByte("57", 16);
        key[15] = Byte.parseByte("3e", 16);
    }

    public final Object clone()
        throws CloneNotSupportedException
    {
        throw new CloneNotSupportedException();
    }

    protected void engineSetPadding(String padding)
        throws NoSuchPaddingException
    {
        if(padding.equals("PKCS5Padding"))
        {
            pad = new PKCS5Padding();
            paddingType = 1;
        } else
        if(padding.equals("NoPadding"))
        {
            pad = new Padding();
            paddingType = 0;
        } else
        if(padding.equals("Zeroes"))
        {
            pad = new Zeroes();
            paddingType = 2;
        } else
        {
            throw new NoSuchPaddingException(padding + " Not supported");
        }
    }

    protected void engineSetMode(String mode)
        throws NoSuchAlgorithmException
    {
        if(mode.equals("ECB"))
        {
            this.mode = 0;
            needIV = false;
        } else
        if(mode.equals("CBC"))
        {
            this.mode = 1;
            needIV = true;
        } else
        if(mode.equals("CFB"))
        {
            this.mode = 2;
            needIV = true;
        } else
        {
            throw new NoSuchAlgorithmException(mode + " Not supported");
        }
    }

    protected int engineGetBlockSize()
    {
        return blockSize;
    }

    protected int engineGetOutputSize(int inputLen)
    {
        int outSize = inputLen + inputBufferOffset;
        if(state == 1)
            outSize += blockSize - outSize % blockSize;
        return outSize;
    }

    protected byte[] engineGetIV()
    {
        return IV;
    }

    protected abstract void initialize(byte abyte0[], AlgorithmParameterSpec algorithmparameterspec)
        throws IllegalStateException, InvalidKeyException;

    protected abstract void encryptBlock(byte abyte0[], byte abyte1[]);

    protected abstract void decryptBlock(byte abyte0[], byte abyte1[]);

    protected void engineInit(int opmode, byte key[], SecureRandom random)
        throws InvalidKeyException
    {
        state = opmode;
        rand = random;
        if(needIV)
        {
            IV = new byte[16];
            IV[0] = Byte.parseByte("30", 16);
            IV[1] = Byte.parseByte("31", 16);
            IV[2] = Byte.parseByte("32", 16);
            IV[3] = Byte.parseByte("33", 16);
            IV[4] = Byte.parseByte("34", 16);
            IV[5] = Byte.parseByte("35", 16);
            IV[6] = Byte.parseByte("36", 16);
            IV[7] = Byte.parseByte("37", 16);
            IV[8] = Byte.parseByte("38", 16);
            IV[9] = Byte.parseByte("39", 16);
            IV[10] = Byte.parseByte("30", 16);
            IV[11] = Byte.parseByte("31", 16);
            IV[12] = Byte.parseByte("32", 16);
            IV[13] = Byte.parseByte("33", 16);
            IV[14] = Byte.parseByte("34", 16);
            IV[15] = Byte.parseByte("35", 16);
            chainBlock = new byte[blockSize];
        }
        initialize(key, null);
        reset();
    }

    protected int engineUpdate(byte input[], int inputOffset, int inputLen, byte output[], int outputOffset)
        throws ShortBufferException
    {
        int consumed = 0;
        int retval = 0;
        byte tempBlock[] = new byte[blockSize];
        int bufferFillRequired;
        int remaining;
        int i;
        if(state == 1)
            do
            {
                bufferFillRequired = blockSize - inputBufferOffset;
                remaining = inputLen - consumed;
                if(bufferFillRequired <= remaining)
                {
                    System.arraycopy(input, consumed + inputOffset, inputBuffer, inputBufferOffset, bufferFillRequired);
                    if(mode == 0)
                    {
                        encryptBlock(inputBuffer, chainBlock);
                        System.arraycopy(chainBlock, 0, output, retval + outputOffset, blockSize);
                    } else
                    if(mode == 1)
                    {
                        for(i = 0; i < blockSize; i++)
                            inputBuffer[i] ^= chainBlock[i];

                        encryptBlock(inputBuffer, chainBlock);
                        System.arraycopy(chainBlock, 0, output, retval + outputOffset, blockSize);
                    } else
                    if(mode == 2)
                    {
                        encryptBlock(chainBlock, tempBlock);
                        for(i = 0; i < blockSize; i++)
                            chainBlock[i] = (byte)(inputBuffer[i] ^ tempBlock[i]);

                        System.arraycopy(chainBlock, 0, output, retval + outputOffset, blockSize);
                    }
                    inputBufferOffset = 0;
                    consumed += bufferFillRequired;
                    retval += blockSize;
                } else
                {
                    System.arraycopy(input, consumed + inputOffset, inputBuffer, inputBufferOffset, remaining);
                    inputBufferOffset += remaining;
                    return retval;
                }
            } while(true);
        if(state == 2)
            do
            {
                bufferFillRequired = blockSize - inputBufferOffset;
                remaining = inputLen - consumed;
                if(remaining - bufferFillRequired >= paddingType)
                {
                    System.arraycopy(input, consumed + inputOffset, inputBuffer, inputBufferOffset, bufferFillRequired);
                    if(mode == 0)
                    {
                        decryptBlock(inputBuffer, tempBlock);
                        System.arraycopy(tempBlock, 0, output, retval + outputOffset, blockSize);
                    } else
                    if(mode == 1)
                    {
                        decryptBlock(inputBuffer, tempBlock);
                        for(i = 0; i < blockSize; i++)
                            output[i + retval + outputOffset] = (byte)(chainBlock[i] ^ tempBlock[i]);

                        System.arraycopy(inputBuffer, 0, chainBlock, 0, blockSize);
                    } else
                    if(mode == 2)
                    {
                        decryptBlock(chainBlock, tempBlock);
                        for(i = 0; i < blockSize; i++)
                            output[i + retval + outputOffset] = (byte)(inputBuffer[i] ^ tempBlock[i]);

                        System.arraycopy(inputBuffer, 0, chainBlock, 0, blockSize);
                    }
                    inputBufferOffset = 0;
                    consumed += bufferFillRequired;
                    retval += blockSize;
                } else
                {
                    System.arraycopy(input, consumed + inputOffset, inputBuffer, inputBufferOffset, remaining);
                    inputBufferOffset += remaining;
                    return retval;
                }
            } while(true);
        else
            return 0;
    }

    protected byte[] engineDoFinal(byte input[], int inputOffset, int inputLen)
        throws IllegalBlockSizeException, BadPaddingException, ShortBufferException
    {
        byte retval[];
        byte output[] = new byte[engineGetOutputSize(inputLen)];
        int done = engineDoFinal(input, inputOffset, inputLen, output, 0);
        retval = new byte[done];
        System.arraycopy(output, 0, retval, 0, done);
        return retval;
        /*ShortBufferException e;
        e;
        e.printStackTrace();
        return null;*/
    }

    protected int engineDoFinal(byte input[], int inputOffset, int inputLen, byte output[], int outputOffset)
        throws ShortBufferException, IllegalBlockSizeException, BadPaddingException
    {
        int produced = engineUpdate(input, inputOffset, inputLen, output, outputOffset);
        if(state == 1)
        {
            if(!pad.doPadding())
                return produced;
            if(mode == 1)
            {
                for(int i = 0; i < blockSize; i++)
                    inputBuffer[i] ^= chainBlock[i];

            }
            encryptBlock(inputBuffer, chainBlock);
            System.arraycopy(chainBlock, 0, output, produced + outputOffset, blockSize);
            reset();
            return produced + blockSize;
        }
        if(state == 2)
        {
            if(inputBufferOffset == 0)
            {
                reset();
                return produced;
            }
            if(inputBufferOffset != blockSize)
                throw new IllegalBlockSizeException("Cipher Text length not a multiple of blockSize");
            byte tempBlock[] = new byte[blockSize];
            decryptBlock(inputBuffer, tempBlock);
            if(mode != 0 && mode == 1)
            {
                for(int i = 0; i < blockSize; i++)
                    tempBlock[i] ^= chainBlock[i];

            }
            int dataSize = pad.doUnPadding(tempBlock);
            System.arraycopy(tempBlock, 0, output, outputOffset + produced, dataSize);
            reset();
            return produced + dataSize;
        } else
        {
            return 0;
        }
    }

    private void reset()
    {
        inputBuffer = new byte[blockSize];
        inputBufferOffset = 0;
        inputBufferLen = 0;
        if(needIV)
            chainBlock = (byte[])IV.clone();
        else
            chainBlock = new byte[blockSize];
    }

    protected byte[] getKey()
    {
        int length = key.length;
        for(int i = 0; i < length; i++)
            key[i] ^= key[length - i - 1];

        return key;
    }

    public static final int ENCRYPT_MODE = 1;
    public static final int DECRYPT_MODE = 2;
    protected static final int STATE_UNITIALIZED = 0;
    protected static final int STATE_ENCRYPT = 1;
    protected static final int STATE_DECRYPT = 2;
    protected static final int MODE_ECB = 0;
    protected static final int MODE_CBC = 1;
    protected static final int MODE_CFB = 2;
    protected static final int MODE_OFB = 4;
    protected static final int NO_PADDING = 0;
    protected static final int PKCS_PADDING = 1;
    protected static final int ZEROS_PADDING = 2;
    private int state;
    private int mode;
    private Padding pad;
    private int paddingType;
    protected int blockSize;
    protected byte IV[];
    private byte key[];
    protected byte inputBuffer[];
    protected int inputBufferOffset;
    protected int inputBufferLen;
    protected byte chainBlock[];
    private SecureRandom rand;
    private boolean needIV;
}
