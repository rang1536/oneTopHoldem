package one.top.holdem.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import one.top.holdem.admin.vo.Event;

@Repository
public class EventDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	 
	// 모든유저 조회
	public List<Event> eventList(){
		return sqlSession.selectList("eventDao.eventList");
	}

}