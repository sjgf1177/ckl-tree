package kr.co.unp.poll.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.unp.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("pollDAO")
public class PollDAO extends EgovAbstractDAO {

	public List<ZValue> selectMasterList(ZValue zvl) {
		return (List<ZValue>)list("pollDAO.selectMasterList", zvl); 
	}

	public List<ZValue> selectCheckformList() {
		return (List<ZValue>)list("pollDAO.selectCheckformList", null); 
	}

	public void insertCheckform(ZValue zvl) {
		insert("pollDAO.insertCheckform", zvl); 
	}

	public ZValue selectCheckform(ZValue zvl) {
		return (ZValue) selectByPk("pollDAO.selectCheckform", zvl); 
	}

	public void updateCheckform(ZValue zvl) {
		update("pollDAO.updateCheckform", zvl); 
	}

	public List<ZValue> selectQuestionList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectQuestionList", zvl); 
	}

	public List<ZValue> selectTestQuestionList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectTestQuestionList", zvl); 
	}

	public List<ZValue> selectAnswerStatisticsList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectAnswerStatisticsList", zvl); 
	}

	public List<ZValue> selectTestAnswerStatisticsList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectTestAnswerStatisticsList", zvl); 
	}

	public void insertQuestion(ZValue zvl) {
		insert("pollDAO.insertQuestion", zvl); 
	}

	public ZValue selectQuestion(ZValue zvl) {
		return (ZValue) selectByPk("pollDAO.selectQuestion", zvl); 
	}

	public void updateQuestion(ZValue zvl) {
		update("pollDAO.updateQuestion", zvl); 
	}
	public List<ZValue> selectQuestion2ForUpdate(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectQuestion2ForUpdate", zvl); 
	}

	public void insertQuestion2(ZValue zvl) {
		insert("pollDAO.insertQuestion2", zvl); 
	}

	public void updateQuestion2(ZValue zvl) {
		update("pollDAO.updateQuestion2", zvl); 
	}

	public ZValue selectMaster(ZValue zvl) {
		return (ZValue) selectByPk("pollDAO.selectMaster", zvl);
	}

	public List<ZValue> selectOngoingMasterList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectOngoingMasterList", zvl);
	}

	public int selectOngoingMasterListCnt(ZValue zvl) {
		return (Integer)selectByPk("pollDAO.selectOngoingMasterListCnt", zvl);
	}

	public List<ZValue> selectFinishedMasterList(ZValue zvl) {
		return (List<ZValue>)list("pollDAO.selectFinishedMasterList", zvl);
	}

	public int selectFinishedMasterListCnt(ZValue zvl) {
		return (Integer)selectByPk("pollDAO.selectFinishedMasterListCnt", zvl);
	}

	public List<ZValue> selectQuestionU(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectQuestionU", zvl);
	}

	public List<ZValue> selectQuestionListM(ZValue zvl) {
		return (List<ZValue>)list("pollDAO.selectQuestionListM", zvl);
	}

	public List<ZValue> selectAnswer(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectAnswer", zvl);
	}

	public List<ZValue> selectAnswerListM(ZValue zvl) {
		return (List<ZValue>)list("pollDAO.selectAnswerListM", zvl);
	}

	public void checkUser(ZValue zvl) {
		insert ("pollDAO.checkUser", zvl);
	}

	public void checkQuestion(ZValue zvl) {
		insert ("pollDAO.checkQuestion", zvl);
	}

	public void checkQuestion2(ZValue zvl) {
		insert ("pollDAO.checkQuestion2", zvl);
	}
	
	public List<ZValue> selectAnswerAndResponse(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectAnswerAndResponse", zvl);
	}

	public List<ZValue> selectOtherList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectOtherList", zvl);
	}

	public List<ZValue> selectEssayList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectEssayList", zvl);
	}

	public void updateQuestionForDelete(ZValue zvl) {
		update("pollDAO.updateQuestionForDelete", zvl); 
	}

	public int selectTempPollId() {
		return (Integer) selectByPk("pollDAO.selectTempPollId", null); 
	}

	public int selectCheckedListTotCnt(ZValue zvl) {
		return (Integer) selectByPk("pollDAO.selectCheckedListTotCnt", zvl);
	}

	public List<ZValue> selectCheckedList(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectCheckedList", zvl); 
	}

	public void deleteQuestion2(ZValue zvl) {
		delete("pollDAO.deleteQuestion2", zvl); 
	}

	public void deleteAnswer2ForCompanyId(ZValue zvl) {
		delete("pollDAO.deleteAnswer2ForCompanyId", zvl); 
	}

	public void delete(int masterCd) {
		delete("pollDAO.deleteAnswer2A", masterCd); 
		delete("pollDAO.deleteQuestion2A", masterCd); 
		delete("pollDAO.deleteQuestionA", masterCd); 
		delete("pollDAO.deleteMasterA", masterCd); 
	}

	public List<ZValue> selectQuestionA(ZValue zvl) {
		return (List<ZValue>) list("pollDAO.selectQuestionA", zvl);
	}

	public ZValue selectRescentPoll() {
		return (ZValue)selectByPk("pollDAO.selectRescentPoll", null);
	}
	
	public List<ZValue> selectPollExceptSatisfaction() {
		return (List<ZValue>)list("pollDAO.selectPollExceptSatisfaction", null);
	}

}
