package API;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;

public class RestAPI {
	private static final String apiKey = "f8d9f9d39a43e6ec63538a5356043b36";
	//private static final String baseURL = "https://developers.zomato.com/api/v2.1/";
	private static final String bulkURL = "https://developers.zomato.com/api/v2.1/search?entity_id=195071&entity_type=landmark";
	private static ArrayList<Integer> restIDs = new ArrayList<Integer>();
	private static HashMap<Integer, Restaurant> allRestaurants = new HashMap<Integer, Restaurant>();
	private static Boolean state = false;

	
	public static HashMap<Integer, Restaurant> getRestaurantMap(){
		return allRestaurants;
	}
	public static void setRestaurantMap(HashMap<Integer, Restaurant> myHash) {
		allRestaurants = myHash;
	}
	
	public static Boolean getState() {
		return state;
	}
	
	public static void setState(Boolean called) {
		state = called;
	}
	
	public static ArrayList<Integer> getRestIDs(){
		return restIDs;
	}
	
	public static void setRestIDs(ArrayList<Integer> arr) {
		restIDs = arr;
	}
	
	public static ArrayList<Integer> getFavorites(){
		ArrayList<Integer> restInList = new ArrayList<Integer>();

		for(int i = 0 ; i < restIDs.size(); i++){
			if(allRestaurants.get(restIDs.get(i)).getFavorite().equals(true)){
				restInList.add(restIDs.get(i));
			}
			System.out.println("restaurant: " + allRestaurants.get(restIDs.get(i)).getFavorite());
		}
		System.out.println("Restaurants in List: " + restInList.size());
		return restInList;
	}
	public static ArrayList<Integer> getToExplores(){
		ArrayList<Integer> restInList = new ArrayList<Integer>();

		for(int i = 0 ; i < restIDs.size(); i++){
			if(allRestaurants.get(restIDs.get(i)).getToExplore().equals(true)){
				restInList.add(restIDs.get(i));
			}
			System.out.println("restaurant: " + allRestaurants.get(restIDs.get(i)).getToExplore());
		}
		System.out.println("Restaurants in List: " + restInList.size());
		return restInList;
	}
	public static ArrayList<Integer> getDoNotShows(){
		ArrayList<Integer> restInList = new ArrayList<Integer>();

		for(int i = 0 ; i < restIDs.size(); i++){
			if(allRestaurants.get(restIDs.get(i)).getDoNotShow().equals(true)){
				restInList.add(restIDs.get(i));
			}
			System.out.println("restaurant: " + allRestaurants.get(restIDs.get(i)).getDoNotShow());
		}
		System.out.println("Restaurants in List: " + restInList.size());
		return restInList;
	}
	
	public static void reRank() {
		for(int i = 0; i < restIDs.size(); i++) {
			for(int j = i; j < restIDs.size(); j++) {
				String[] splitI = allRestaurants.get(restIDs.get(i)).getTravelTime().split(" ");
				String[] splitJ = allRestaurants.get(restIDs.get(j)).getTravelTime().split(" ");
				if(Integer.valueOf(splitJ[0]) < Integer.valueOf(splitI[0])) {
					Collections.swap(restIDs, i, j);
				}
			}
		}
		for(int i = 0; i < restIDs.size(); i++) {
			System.out.println(i+". "+allRestaurants.get(restIDs.get(i)).getTravelTime());
		}
	}
	
	private static String travelTime(double lat1, double lon1, double lat2, double lon2, String key) throws Exception{
		String link = "https://maps.googleapis.com/maps/api/directions/json?origin=";
		URL obj = new URL(link+lat1+","+lon1+"&destination="+lat2+","+lon2+"&key="+key);
		HttpURLConnection con =(HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		int responseCode = con.getResponseCode();
		
		System.out.println("\nSending 'GET' request to URL : " + link+lat1+","+lon1+"&destination="+lat2+","+lon2+"&key="+key);
	    System.out.println("Response Code : " + responseCode);
	    
	    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    String inputLine;
	    StringBuffer response = new StringBuffer();
	    while ((inputLine = in.readLine()) != null) {
	        response.append(inputLine);
	    }
	    in.close();
	    JSONObject myResponse = new JSONObject(response.toString());
	    
	    String travelTime = myResponse.getJSONArray("routes").getJSONObject(0).getJSONArray("legs").getJSONObject(0).getJSONObject("duration").getString("text");
	    System.out.println(travelTime);
	    
	    
		return travelTime;
	}
	
	public static HashMap<Integer, Restaurant> call_me(String searchTerm, int resultLimit) throws Exception {
		HashMap<Integer, Restaurant> newRests = new HashMap<Integer, Restaurant>();
		ArrayList<Integer> newRestIDs = new ArrayList<Integer>();
		
		String fullURL = bulkURL+"&q=" + searchTerm + "&count=" + resultLimit;
	    
		URL obj = new URL(fullURL);
		
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		con.addRequestProperty("user-key", apiKey);
		int responseCode = con.getResponseCode();
		
		System.out.println("\nSending 'GET' request to URL : " + fullURL);
	    System.out.println("Response Code : " + responseCode);
	    
	    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    String inputLine;
	    StringBuffer response = new StringBuffer();
	    while ((inputLine = in.readLine()) != null) {
	        response.append(inputLine);
	    }
	    in.close();
	    
	    System.out.println(response.toString());
	    	    
	    JSONObject myResponse = new JSONObject(response.toString());
	    JSONArray array = myResponse.getJSONArray("restaurants");
	    System.out.println("result after Reading JSON Response");
	    
	    
	    for (int i = 0; i < array.length(); i++) {
	    	JSONObject test = array.getJSONObject(i);
	    	JSONObject test2 = test.getJSONObject("restaurant");
	    	JSONObject location = test2.getJSONObject("location");
	    	JSONObject userRating = test2.getJSONObject("user_rating");
	    	
	    	Restaurant newRest = new Restaurant(test2.getInt("id"));
	    	
	    	newRest.setName(test2.getString("name"));
	    	newRest.setAddress(location.getString("address"));
	    	newRest.setLatitude(location.getDouble("latitude"));
	    	newRest.setLongitude(location.getDouble("longitude"));
	    	newRest.setRating(userRating.getDouble("aggregate_rating"));
	    	newRest.setURL(test2.getString("url"));
	    	newRest.setPriceRange(test2.getDouble("average_cost_for_two"));
	    	
	    	String newTravelTime = travelTime(34.0224, -118.2851, newRest.getLatitude(), newRest.getLongitude(), "AIzaSyA8VQVUyJJIhDwm2hKITkLeCqUqyiL9Y1w");

	    	//https://maps.googleapis.com/maps/api/directions/json?origin=34.0224, -118.2851&destination=34.0166,-118.2816&key=AIzaSyA8VQVUyJJIhDwm2hKITkLeCqUqyiL9Y1w

	    	newRest.setTravelTime(newTravelTime);
	    	
	    	newRests.put(test2.getInt("id"), newRest);
	    	newRestIDs.add(test2.getInt("id"));
	    	
		    System.out.println(test2.get("name"));
		    System.out.println("");
	    }
	    allRestaurants = newRests;
	    restIDs = newRestIDs;
	    reRank();
	    for(int i = 0;i<restIDs.size(); i++) {
	    	System.out.println(restIDs.get(i));
	    }
	    
	    for (int i = 0; i < allRestaurants.size(); i++) {
	    	Restaurant newRest = allRestaurants.get(restIDs.get(i));
	    	System.out.println("Restaurant Name: " + newRest.getName());
	    	System.out.println("Restaurant Address: " + newRest.getAddress());
	    	System.out.println("Latitude: " + newRest.getLatitude());
	    	System.out.println("Longitude: " + newRest.getLongitude());
	    	System.out.println("Rating: " + newRest.getRating());
	    	System.out.println("URL: " + newRest.getURL());
	    	//new test below
	    	System.out.println("TESTING");
	    	System.out.println("$: " + newRest.getPriceRange());
	    	System.out.println("Distance: " + newRest.getTravelTime());
	    }
	    return allRestaurants;
	}
}