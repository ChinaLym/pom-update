package org.lym.pom.util;

import java.io.File;

/**
 * 删除 idea 自带的文件，方便上传 git
 * @author lym
 */
public class CleanIdeaFiles {
    public static void main(String[] args) {
        trace(new File("F:\\temp\\shoulder-framework"));

    }

    static void trace(File file){
        String fileName = file.getName();
        if(".idea".equals(fileName) || fileName.endsWith(".iml")){
            System.out.println("delete " + file.getAbsolutePath());
            remove(file);
        }
        if(!file.isDirectory()){
            return;
        }
        File[] files = file.listFiles();
        if (files == null || files.length == 0){
            return;
        }
        for (File f : files){
            trace(f);
        }
    }

    public static void remove(File f) {
        if(!f.exists()){
            return;
        }
        System.out.println("deleted file ::  "+ f.getAbsolutePath());
        if(!f.isDirectory()){
            f.delete();
        }
        File files[] = f.listFiles();
        for (int i = 0; i < files.length; i++) {
            remove(files[i]);
        }
        //删除目录自身
        f.delete();
        System.out.println("deleted DIR ::  "+f.toString());
    }
}
