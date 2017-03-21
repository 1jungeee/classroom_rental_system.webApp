<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form>
	<table class="table table-bordered" style="table-layout:fixed; margin-bottom:0px;">
	<tr style="color:black; background-color:#fcf8e3; padding:0px;">
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">시간</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">월</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">화</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">수</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">목</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">금</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">토</th>
		<td class="text-center" style="font-size:13; font-family:Arial; padding:0px;">일</th>
	</tr>
	${timetable}
	</table>
</form>