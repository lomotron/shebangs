///usr/bin/env javac $0;/usr/bin/env java -cp $(basename ${0%.*}) $0 ${@}; exit $?
import java.io.File;
import java.io.FileInputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;
public class test {
    public static void main(String[] args) throws Exception{
        if (args.length == 0) throw new Exception("Must pass Filename");
        FileInputStream fis=new FileInputStream(new File(args[0]));
        MessageDigest md= MessageDigest.getInstance(args.length>1?args[1]:"SHA-256");
        DigestInputStream dis = new DigestInputStream(fis,md);
        while (dis.read() != -1){}
        byte[] dig = md.digest();
        for (byte i: dig) System.out.print(String.format("%02x",i));
    }
}

