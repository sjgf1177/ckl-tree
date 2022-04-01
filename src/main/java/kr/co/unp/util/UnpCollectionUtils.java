package kr.co.unp.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.vo.FileVO;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;

public abstract class UnpCollectionUtils {

	public static <T> Map<String, List<T>> convertMap(List<T> list, String prefix, String key) throws Exception{
		if( CollectionUtils.isEmpty(list) ){
			return Collections.emptyMap();
		}
		
		Map<String, List<T>> map = new HashMap<String, List<T>>();
		for( T t : list )
		{
			String keyVal = prefix + PropertyUtils.getProperty(t, key);
			list = map.get(keyVal);
			if( list == null )
			{
				list = new ArrayList<T>();
				list.add( t );
				map.put(keyVal, list);
			}
			else
			{
				list.add( t );
			}
		}
		return map;
	}

	public static <T> void setFirstFile(List<T> list, Map<String, List<FileVO>> fileMap, String fieldName) throws Exception {
		if (CollectionUtils.isNotEmpty(list)) {
			if (MapUtils.isNotEmpty(fileMap)) {
				for (T val : list) {
					List<FileVO> files = fileMap.get(PropertyUtils.getProperty(val, fieldName));
					if (CollectionUtils.isNotEmpty(files)) {
						PropertyUtils.setProperty(val, "fileSn", files.get(0).getFileSn());
						PropertyUtils.setProperty(val, "fileCn", files.get(0).getFileCn());
						PropertyUtils.setProperty(val, "streFileNm", files.get(0).getStreFileNm());
					}
				}
			}
		}
	}

	public static <T> void setFileToList(List<T> list, Map<String, List<FileVO>> fileMap, String fieldName, String matchingFileFieldName) throws Exception{
		if (CollectionUtils.isNotEmpty(list)) {
			if (MapUtils.isNotEmpty(fileMap)) {
				for (T val : list) {
					List<FileVO> files = fileMap.get(PropertyUtils.getProperty(val, fieldName));
					if (CollectionUtils.isNotEmpty(files)) {
						for(FileVO file : files){
							String fileFieldName = file.getFileFieldName();
							if( fileFieldName.equals(matchingFileFieldName) ){
								PropertyUtils.setProperty(val, "fileSn", file.getFileSn());
								PropertyUtils.setProperty(val, "fileCn", file.getFileCn());
								PropertyUtils.setProperty(val, "streFileNm", file.getStreFileNm());
								break;
							}
						}
					}
				}
			}
		}
	}
}
