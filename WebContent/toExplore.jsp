<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>To Explore</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	 	<link rel="stylesheet" type="text/css" href="favorites.css" />
	 	
	</head>
	<body>
		<div class="container-fluid">
		 <h1 id="title">To Explore</h1>
		  <div class="row">
		    <div class="col-lg-8" style="background-color:lavender;">
		    	<p>
		    		Title
				</p></br>
		    	<p>
		    		Distance
		    	</p></br>
		    	<p>
		    		Address
		    	</p></br>
		    	<p>
		    		Star Rating
		    	</p></br>
		    
		    </div>
		    <div class="col-lg-4" style="background-color:lavenderblush;">
					<select id="mySelect">
					  <option></option>
					  <option value="favorites.jsp">Favorites</option>
					  <option value="toExplore.jsp">To Explore</option>
					  <option value="doNotShow.jsp">Do Not Show</option>
					</select></br></br>
		
				<button type="button" onclick="manageList()">Manage List</button></br></br>
				<button onclick="returnToResults()">Return to Results Page</button></br></br>
				<button onclick="returnToSearch()">Return to Search Page</button></br></br>
			</div>
		  </div>
		</div>
	
		<script>		 
			function returnToSearch() {
				window.location.href = 'searchPage.html';
			}
			function returnToResults() {
				window.location.href = 'resultsPage.jsp';
			}
			function manageList() {
				var link = document.getElementById("mySelect").selectedIndex;
				if(link == "1"){
					window.location.href = 'favorites.jsp';
				}	
				else if(link == "2"){
					window.location.href = 'toExplore.jsp';
				}
				else if(link == "3"){
					window.location.href = 'doNotShow.jsp';
				}
			}
		</script>
	
	</body>
</html>