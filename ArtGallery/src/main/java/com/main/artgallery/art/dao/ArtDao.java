package com.main.artgallery.art.dao;

import java.util.List;

import com.main.artgallery.art.dto.ArtDto;


public interface ArtDao {

	//-------- Son ----------------------
	public List<ArtDto> getArtList(ArtDto dto);
	public List<ArtDto> getSearchList(String SearchKeyword);

	
	//-------- hyung ----------------------

	public List<ArtDto> getList(ArtDto dto);
	public int getCount(ArtDto dto);
	public void insert(ArtDto dto);
	public ArtDto getData(ArtDto dto);
	public void update(ArtDto dto);
	public void delete(int seq);
	public int getSequence();	// sequence값 가져오기
	public void addViewCount(int seq);
}
