DST2 - Technological Stack 

• Java – The programing language 

• SQL – The data operation language 

• MySQL – Structured data storage and retrieval 

• Tomcat – Web server, a Container: we make artifacts (compiled java program that are capable of processing data ) and put artifacts in the container. The container will serve as the middle layer between user and artifacts, passing user requests to artifacts and passing artifact responses to user. 

• Maven – A muti-purpose tool for making a program. It manages dependent libraries, builds program, and generates API documents. 

• JDBC – A java interface library to interact with DBMS, like MySQL

• Servlet – Base Java web technology to write an artifact for Web server container. Many more advanced web technologies are based on Servlets. They are eventually converted to Servlets. Servlets are simple, and because its simplicity, they are still frequently used as Controller in the MVC programming model, as in the System Architecture. 

• HTML – A markup language that describes what a web page shall look like. Web server responds to user requests by providing a HTML file to user browser, so that user sees the web page described by the HTML. 

• JavaScript – A Java-like but non-Java language that runs in the browser. It is often embedded in an HTML file. JavaScript program interacts with HTML elements to dynamically change the appearance of the web page

• JSP – Advanced web technology that embeds java code into an HTML, providing more intuitive way for us to specify the correspondence between program data and web page element. JSP is eventually compiled to Servlet. 

• JSTL – Advanced web technology that uses tags to simulate java language functions. JSTL file looks more like a pure HTML rather than a hybrid of HTML and Java. It provides tighter integration HTML and Java, and looks more what-you-see-is-what-youget. JSTL is eventually compiled to Servlet. 

• MVC – A programming pattern to divide a system to three parts: Model: using java objects to store data. View: using JSP/JSTL or Servlet to present data as HTML(possibly with embedded JavaScript). Controller, processing and controlling data flow.

1.3 Tasks 

1. Download and install IntelliJ IDEA.
2. Download and install any SQL Server (e.g. my SQL or PostgreSQL).
3. Register an account on Gitee ([https://gitee.com/](https://gitee.com/)) and get familiar with this code repository

2.3 Tasks 

1. Clone the provided base system from Gitee.  [https://gitee.com/zje-dst2/haining_biomed/](https://gitee.com/zje-dst2/haining_biomed/)
2. Setup local database for account, database, schema, and tables (branch Week21: git checkout Week21)
3. Retrieve PharmGkb data (branch Week16).
4. Import retrieved data to local database (branch Week21, “cmd” folder).
5. Setup local web server (tomcat 8).
6. Config provided system to deploy on local web server.
7. Test local web service (branch Week21)
8. Find and read documents on the Internet regarding the implementation of waterfall model.
9. Determine stage team lead for each development stage.
10. Setup group git repository (copy branch Week21 as first commit).

3.3 Tasks

1. Ensure that the provided system works (in the cloned repository).
2. Setup group project repository. Use the provided Week 21 codes as initial commit. Ensure that the initial commit of your group project repository works.
3. Develop a visitor counter web application in a new branch. Every time you visit the page, the number displayed will be increased by one.

• [https://tomcat.apache.org/tomcat-5.5-](https://tomcat.apache.org/tomcat-5.5-)doc/servletapi/javax/servlet/http/package-summary.html

• [https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaServlets.h](https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaServlets.h)tml

• [https://gitee.com/zje-dst2/haining_biomed/tree/Week17/](https://gitee.com/zje-dst2/haining_biomed/tree/Week17/)

4.3 Tasks: Ref Maven (Project Object Model (POM)) & JDBC

Play with Week 17 codes

5 & 6 Tasks: explore example code with AI + design improvements

7.3 Tasks 

Track data flow in the example system using break points. 

Log program execution trace using SLF4J

9.3Tasks 

Implement your data design in separate DBMS schema. 

Implement your data design in separate DAO classes. 

Use tests to verify your implementation