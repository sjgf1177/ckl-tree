// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   C_PP_CLI.java

package com.kcp;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class C_PP_CLI
{

    public C_PP_CLI()
    {
        m_bSetEnv = false;
        m_c_strHomeDir = "";
        m_c_strPAURL = "";
        m_c_strPAPorts = "";
        m_nTxMode = 0;
        m_c_strSite_CD = "";
        m_c_strSite_Key = "";
        m_c_strTx_CD = "";
        m_c_strOrdr_IDxx = "";
        m_c_strPayx_Data = "";
        m_c_strOrdr_Data = "";
        m_c_strRcvr_Data = "";
        m_c_strEscw_Data = "";
        m_c_strModx_Data = "";
        m_c_strEncData = "";
        m_c_strEncInfo = "";
        m_c_strTraceNo = "";
        m_c_strCust_IP = "";
        m_c_strLogLevel = "";
        m_c_strOpt = "";
        m_nReqDataNo = 0;
        m_nResDataCnt = 0;
        m_res_cd = "";
        m_res_msg = "";
    }

    public void mf_init(String s, String s1, String s2, int i)
    {
        m_bSetEnv = true;
        m_c_strHomeDir = s;
        m_c_strPAURL = s1;
        m_c_strPAPorts = s2;
        m_nTxMode = i;
    }

    public void mf_init_set()
    {
        try
        {
            m_c_straReqData = new String[20][2];
            for(int i = 0; i < 20; i++)
            {
                m_c_straReqData[i][0] = "";
                m_c_straReqData[i][1] = "";
            }

            m_nReqDataNo = 0;
            m_c_strEncData = "";
            m_c_strEncInfo = "";
        }
        catch(Exception exception)
        {
            m_res_cd = "S301";
            m_res_msg = "\uC694\uCCAD \uC815\uBCF4 \uC800\uC7A5 BUFFER \uC0DD\uC131 \uC624\uB958 : " + exception;
        }
    }

    public int mf_add_set(String s)
    {
        int i;
        for(i = 0; i < m_nReqDataNo && !m_c_straReqData[i][0].equals(s); i++);
        if(i == m_nReqDataNo)
        {
            m_c_straReqData[i][0] = s;
            m_nReqDataNo++;
        }
        return i;
    }

    public void mf_set_us(int i, String s, String s1)
    {
        if(s1 != null && s1.length() != 0)
            m_c_straReqData[i][1] += s + "=" + s1 + String.valueOf('\037');
    }

    public void mf_set_gs(int i, String s, String s1)
    {
        if(s1 != null && s1.length() != 0)
            m_c_straReqData[i][1] += s + "=" + s1 + String.valueOf('\035');
    }

    public void mf_set_enc_data(String s, String s1)
    {
        m_c_strEncData = s;
        m_c_strEncInfo = s1;
    }

    public void mf_set_trace_no(String s)
    {
        m_c_strTraceNo = s;
    }

    public void mf_add_rs(int i, int j)
    {
        m_c_straReqData[i][1] += m_c_straReqData[j][0] + "=" + m_c_straReqData[j][1] + String.valueOf('\036');
    }

    public void mf_do_tx(String s, String s1, String s2, String s3, String s4, String s5, String s6)
    {
        String s7;
        boolean flag;
        s7 = "";
        flag = true;
        if(m_bSetEnv)
        {
            m_c_strSite_CD = s;
            m_c_strSite_Key = s1;
            m_c_strTx_CD = s2;
            m_c_strCust_IP = s3;
            m_c_strOrdr_IDxx = s4;
            m_c_strLogLevel = s5;
            m_c_strOpt = s6;
            m_c_strPayx_Data = cf_set_tx_data("payx_data");
            m_c_strOrdr_Data = cf_set_tx_data("ordr_data");
            m_c_strRcvr_Data = cf_set_tx_data("rcvr_data");
            m_c_strEscw_Data = cf_set_tx_data("escw_data");
            m_c_strModx_Data = cf_set_tx_data("mod_data");
            if(m_nTxMode != 1)
                s7 = cf_do_tx_exe();
        } else
        {
            s7 = "res_cd=9551" + String.valueOf('\037') + "res_msg=\uCD08\uAE30\uD654 \uD568\uC218\uB97C \uD638\uCD9C\uD558\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4.";
        }
        if(s7 == null)
            s7 = "ABCD";
        int i = s7.length();
        int k = 0;
        m_nResDataCnt = 1;
        for(; k < i; k++)
            if(s7.charAt(k) == '\037')
                m_nResDataCnt++;

        try
        {
            m_c_straResData = new String[m_nResDataCnt][2];
        }
        catch(Exception exception)
        {
            flag = false;
            m_res_cd = "9552";
            m_res_msg = "\uACB0\uACFC\uAC12 \uC800\uC7A5 BUFFER \uC0DD\uC131 \uC624\uB958 : " + exception;
            m_nResDataCnt = 0;
        }
        try
        {
            StringTokenizer stringtokenizer = new StringTokenizer(s7, String.valueOf('\037'));
            String s8 = "";
            int l;
            for(l = 0; l < m_nResDataCnt && stringtokenizer.hasMoreTokens(); l++)
            {
                String s9 = stringtokenizer.nextToken();
                int j = s9.indexOf("=");
                if(j > -1)
                {
                    m_c_straResData[l][0] = s9.substring(0, j);
                    m_c_straResData[l][1] = s9.substring(j + 1);
                    if(m_c_straResData[l][0].equals("res_cd"))
                    {
                        m_res_cd = m_c_straResData[l][1];
                        continue;
                    }
                    if(m_c_straResData[l][0].equals("res_msg"))
                        m_res_msg = m_c_straResData[l][1];
                } else
                {
                    m_c_straResData[l][0] = s9;
                    m_c_straResData[l][1] = "";
                }
            }

            if(l == 0)
                m_nResDataCnt = 0;
        }
        catch(Exception exception1)
        {
            boolean flag1 = false;
            m_res_cd = "9553";
            m_res_msg = "\uACB0\uACFC DATA \uC624\uB958 : " + exception1;
            m_nResDataCnt = 0;
        }
    }

    public String mf_get_res(String s)
    {
        String s1 = "";
        int i = 0;
        do
        {
            if(i >= m_nResDataCnt)
                break;
            if(m_c_straResData[i][0].equals(s))
            {
                s1 = m_c_straResData[i][1];
                break;
            }
            i++;
        } while(true);
        if(i == m_nResDataCnt)
            if(s.equals("res_cd"))
                s1 = m_res_cd;
            else
            if(s.equals("res_msg"))
                s1 = m_res_msg;
        return s1;
    }

    private String cf_set_tx_data(String s)
    {
        for(int i = 0; i < 20; i++)
            if(m_c_straReqData[i][0].equals(s))
                return s + "=" + m_c_straReqData[i][1];

        return "";
    }

    private String cf_do_tx_exe()
    {
        String s;
        s = "";
        boolean flag = true;
        try
        {
            String as[] = {
                m_c_strHomeDir + "/bin/pp_cli", "-h", "home=" + m_c_strHomeDir + "," + "site_cd=" + m_c_strSite_CD + "," + "site_key=" + m_c_strSite_Key + "," + "tx_cd=" + m_c_strTx_CD + "," + "pa_url=" + m_c_strPAURL + "," + "pa_port=" + m_c_strPAPorts + "," + "ordr_idxx=" + m_c_strOrdr_IDxx + "," + "payx_data=" + m_c_strPayx_Data + "," + "ordr_data=" + m_c_strOrdr_Data + "," + "rcvr_data=" + m_c_strRcvr_Data + "," + "escw_data=" + m_c_strEscw_Data + "," + "modx_data=" + m_c_strModx_Data + "," + "enc_data=" + m_c_strEncData + "," + "enc_info=" + m_c_strEncInfo + "," + "trace_no=" + m_c_strTraceNo + "," + "cust_ip=" + m_c_strCust_IP + "," + "log_level=" + m_c_strLogLevel + "," + "opt=" + m_c_strOpt + ""
            };
            Process process = Runtime.getRuntime().exec(as);
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String s1;
            while((s1 = bufferedreader.readLine()) != null) 
                s = s + s1;
        }
        catch(Exception exception)
        {
            boolean flag1 = false;
            s = "res_cd=S102" + String.valueOf('\037') + "res_msg=\uC5F0\uB3D9 \uBAA8\uB4C8 \uC2E4\uD589 \uC624\uB958 : " + exception;
        }
        return s;
    }

    private boolean m_bSetEnv;
    private String m_c_strHomeDir;
    private String m_c_strPAURL;
    private String m_c_strPAPorts;
    private int m_nTxMode;
    private String m_c_strSite_CD;
    private String m_c_strSite_Key;
    private String m_c_strTx_CD;
    private String m_c_strOrdr_IDxx;
    private String m_c_strPayx_Data;
    private String m_c_strOrdr_Data;
    private String m_c_strRcvr_Data;
    private String m_c_strEscw_Data;
    private String m_c_strModx_Data;
    private String m_c_strEncData;
    private String m_c_strEncInfo;
    private String m_c_strTraceNo;
    private String m_c_strCust_IP;
    private String m_c_strLogLevel;
    private String m_c_strOpt;
    private int m_nReqDataNo;
    private String m_c_straReqData[][];
    private String m_c_straResData[][];
    private int m_nResDataCnt;
    public String m_res_cd;
    public String m_res_msg;
}
