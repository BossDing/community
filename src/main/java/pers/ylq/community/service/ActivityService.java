package pers.ylq.community.service;

import com.github.pagehelper.PageInfo;
import pers.ylq.community.entity.Activity;

import java.util.List;

public interface ActivityService {
    PageInfo findAll(int currentPage, int pageSize);

    Activity findActivityById(Integer activityId);
}
