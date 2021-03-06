<%@page import="java.util.HashMap,java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.rlovep.entity.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 定义标签 -->
<%@taglib prefix="rlovep" uri="http://rlovep.com" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>el表达式学习：</title>
</head>
<body>
<%--el的内置对象 --%>
 <%
 	pageContext.setAttribute("name", "peace");
 	pageContext.setAttribute("age", "22", pageContext.APPLICATION_SCOPE);
 %>
 <%--直接从域中搜索获得属性 --%>
 El表达式：${name }
 <hr/>
 <%--等价于 --%>
 表达式：<%=pageContext.findAttribute("name") %>
 <hr/>
 <%--从指定域中获取属性 --%>
 EL表达式：${applicationScope.age}
 <hr/>
 <%--等价于 --%>
 <%=pageContext.getAttribute("age", pageContext.APPLICATION_SCOPE) %>
 <hr/>
 <%--获取请求参数 --%>
 请求参数${param.pass}
 <hr/>
<%--请求头获取 --%>
请求头${header.Host}
<%--还可以获得初始参数：initparam 以及cookie --%>
<hr/>
<%--el输出对象的属性 ,必须将对象放入域中--%>
<%
	Student student=new Student("peace",22);
	String a="123";
	//放入域中
   pageContext.setAttribute("student", student);
	//放入list中
	List<Student> list=new ArrayList<Student>();
	list.add(new Student("sisi",22));
	list.add(new Student("nick",20));
	list.add(new Student("lucy",38));
	pageContext.setAttribute("list", list);
	//放入map中
	Map<String,Student> map=new HashMap<String,Student>();
	map.put("100",new Student("mark",20));
 	map.put("101",new Student("maxwell",30));
 	map.put("102",new Student("narci",40));
 	//放入域中
 	pageContext.setAttribute("map",map);
%>
<%--使用el获取对象值 --%>
${student.name } -${student.age }
 <%--
       ${student.name} 等价于     （点相对于调用getXX（）方法）
          <%=((Student)pageContext.findAttribute("student")).getName()%>
       --%>
       
       <hr/>
       <%--使用EL获取List对象 --%>
       ${list[0].name } - ${list[0].age }<br/>
       ${list[1].name } - ${list[1].age }<br/>
       ${list[2].name } - ${list[2].age }
       <%--
       list[0]等价于       (中括号相对于调用get(参数)方法)
       		((List)pageContext.findAttribute("list")).get(0)
        --%>
        <hr/>
        <%--使用EL获取Map对象 --%>
        ${map['100'].name } -  ${map['100'].age }<br/>
        ${map['101'].name } -  ${map['101'].age }<br/>
        ${map['102'].name } -  ${map['102'].age }<br/>
<%--el还可以执行算法表达式 --%>

<%--el表达语言的自定义函数 
本质是为了调用提供一种方法允许el中调用某类的静态方法：
1.在src建立开发处理类，这个类包含若干个静态方法。当然这个步骤可以省掉使用jdk库的类也是可以的
2.使用标签库定义函数：定义函数的方式与定义标签的方式相似。增加function标签就行；
3.增加taglib指令
--%>
此去表达式调用函数：<br/>

peace倒转：${rlovep:reverse(student.name)}<%--调用reverse方法使传入的student.name反转--%>
<br/>
peace字符个数：${rlovep:count(student.name)}
</body>
</html>