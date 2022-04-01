package com.siren24;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

public class PCIClient
{
	private Socket sock;
	private String host = "";
	private int port = 0;
	private String flag = "";
	private DataInputStream in;
	private DataOutputStream out;
	private String message = "";
	private byte[] head = new byte[2]; 
	private String shead = "";
	private byte[] body = null;
	private String sbody = "";
	private int sendDataLength = 0;
	private String recvData = "";
    private String strKey = "";
    private byte[] decryptText;

    public String returnReviceData(){
    	String resultMsg = new String(this.decryptText);
		System.out.println("Receiving DATA Error!!!"+resultMsg);
    	return resultMsg;
    }
    
	public PCIClient(String host, String port, String option, String key, String message)
	{
		this.host = host;
		this.port = Integer.parseInt(port);
		this.flag = option;
		this.message = this.convertAsciiToKor(message);

		this.strKey = key;

		this.init();
	}

	public void init()
	{
		try {
			this.sock = new Socket(this.host, this.port);
			this.in = new DataInputStream(new BufferedInputStream(this.sock.getInputStream()));
			this.out = new DataOutputStream(new BufferedOutputStream(this.sock.getOutputStream()));
		} catch(UnknownHostException e1) {
			System.out.println("Unkown Host!!!");
			this.helpToSystem();
			e1.printStackTrace();
		} catch(Exception e) {
			System.out.println("���� Ȱ��ȭ�Ǿ���� ���� Ȯ���Ͻʽÿ�.!!!");
			this.helpToSystem();
			System.exit(1);
		}

		this.MakeHeadBody(this.message);

		boolean flag = true;

		flag = this.sendMessage();

		if(!flag)
		{
			System.out.println("Sending DATA Error!!!");
			System.exit(1);
		}

		flag = this.receive();

		if(!flag)
		{
			System.out.println("Receiving DATA Error!!!");
			System.exit(1);
		}
	}

	public boolean sendMessage()
	{
		boolean flag = true;

		try {
			boolean f = true;
			f = this.sendHead();

			if(!f)
			{
				System.out.println("Sending HEAD Error!!!");
				System.exit(1);
			}

			f = this.sendBody();
			if(!f)
			{
				System.out.println("Sending BODY Error!!!");
				System.exit(1);
			}
		} catch(Exception e) {
			System.out.println("Message Sending Exceptione!!!");
			e.printStackTrace();
			return false;
		}

		return flag;
	}

	public void helpToSystem()
	{
	   	System.out.println("Usage : java  PCIClient  <server-ip>  <port>  <sample.sam> Y  <Key> ");
	}

	public void MakeHeadBody(String str)
	{
		try
		{

			this.head = str.substring(0, 2).getBytes("8859_1");
			byte[] lpszIDCD = str.substring(2, 6).getBytes("8859_1");
			String strIDCD = new String(lpszIDCD, "KSC5601");
			byte[] data  = (str.substring(6, str.length()).getBytes());

			for(int i = 0; i < data.length; i++)
			{
				System.out.print(Byte.toString(data[i]) + " ");
			}

			System.out.println("");

			byte [] lpszBuffer = Base64.base64Encode(SymmetricCipher.SEED_CBC_ENCRYPT(data, this.strKey.getBytes()));

			this.body = new byte [ 4 + lpszBuffer.length ];

			for(int i = 0; i < 4; i++) this.body[i] = lpszIDCD[i];
			for(int i = 0; i < lpszBuffer.length; i++) this.body[i + 4] = lpszBuffer[i];

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	// ��� ���
	synchronized public boolean sendHead()
	{
		boolean recv = true;

		try {
			this.out.write(this.head);
			//this.out.flush();
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}

		return recv;
	}

	// �ٵ� ���
	synchronized public boolean sendBody()
	{
		boolean recv = true;

		try {
			this.out.write(this.body);
			this.out.flush();
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}

		return recv;
	}

	// ����κ��� �����͸� ���
	synchronized public boolean receive()
	{
		boolean flag = true;
		String recvData = "";

		try {
			byte[] data = this.getSocketMessage();

			this.decryptText = SymmetricCipher.SEED_CBC_DECRYPT(data, this.strKey.getBytes());

		} catch(Exception ex) {
			ex.printStackTrace();
			return false;
		}

		try {
			this.sock.close();
		} catch(Exception e1) {
		}

		return flag;
	}

	public byte[] getSocketMessage()
	{

		byte[] tempBuffer = new byte[1024];
		byte[] buffer = null;
		byte[] base64Buffer = null;

		try {
			int count = 0;

			if(this.in.read(tempBuffer) != -1)
			{
				for(int i=0; i<tempBuffer.length; i++)
				{
					if(tempBuffer[i] == 0x00) break;
					count++;
				}
			}

			buffer = new byte[count];

			for(int j=0; j<count; j++)
			{
				buffer[j] = tempBuffer[j];
			}

			base64Buffer = Base64.base64Decode(buffer);

		} catch(Exception e) {
			System.out.println("Socket Reading Exceptione!!1");
			e.printStackTrace();
		}

		return base64Buffer;

	}

	//���ڿ�; /���ڵ�� ��ȯ�ϴ� �޼ҵ�
	private String convertAsciiToKor(String uni)
	{
		String result = null;

		try {
			  if(uni == null) return null;
			  result = new String(uni.getBytes("EUC-KR"), "KSC5601");
		} catch(Exception e) {
			  System.out.println(e);
		}
		return result;
	}


}
