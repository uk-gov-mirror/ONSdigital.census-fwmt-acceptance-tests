package uk.gov.ons.fwmt.acceptancetests.smoketest;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import cucumber.api.java.en.Given;
import org.apache.commons.codec.binary.Base64;
import org.junit.Assert;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;


public class GatewaySmokeTestSteps {

  static final String RMA_URL = System.getenv("RMA_URL");
  static final String RMA_RABBIT_URL = System.getenv("RMA_RABBIT_URL");

  static final String JS_USERNAME = System.getenv("JS_USERNAME");
  static final String JS_PASSWORD = System.getenv("JS_PASSWORD");
  static final String JS_URL = System.getenv("JS_URL");
  static final String JS_RABBIT_URL =  System.getenv("JS_RABBIT_URL");

  static final String TM_USERNAME = System.getenv("TM_USERNAME");
  static final String TM_PASSWORD = System.getenv("TM_PASSWORD");
  static final String TM_URL = System.getenv("TM_URL");




static final String username = System.getenv("RABBIT_USER");
  static final String password = System.getenv("RABBIT_PASSWORD");
  static final String hostname = System.getenv("RABBIT_HOSTNAME");
  static final String port = System.getenv("RABBIT_PORT");

  static final String virtualHost = "/";

  @Given("^Check RmAdpater is running$")
  public void checkAdpaterRunning() throws Exception {

    final String uri = RMA_URL;

    RestTemplate restTemplate = new RestTemplate();
    String result = restTemplate.getForObject(uri, String.class);

    Assert.assertTrue(result.contains("\"status\":\"UP\""));
  }

  @Given("^Check Job Service is running$")
  public void checkJobserviceRunning() throws Exception {

    final String plainCreds = JS_USERNAME+":"+JS_PASSWORD;
    byte[] plainCredsBytes = plainCreds.getBytes();
    byte[] base64CredsBytes = Base64.encodeBase64(plainCredsBytes);
    String base64Creds = new String(base64CredsBytes);

    HttpHeaders headers = new HttpHeaders();
    headers.add("Authorization", "Basic " + base64Creds);

    final String url = JS_URL;
    RestTemplate restTemplate = new RestTemplate();

    HttpEntity<String> request = new HttpEntity<String>(headers);
    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, request, String.class);
    String result = response.getBody();

    Assert.assertTrue(result.contains("\"status\":\"UP\""));
  }


  @Given("^Check RM Rabbit is running$")
  public void checkRMRabbitRunning() throws Exception {
    final String uri = RMA_RABBIT_URL;

    RestTemplate restTemplate = new RestTemplate();
    String result = restTemplate.getForObject(uri, String.class);

    Assert.assertTrue(result.equalsIgnoreCase("true"));

  }

  @Given("^Check Rabbit is running$")
  public void checkRabbitRunning() throws Exception {


    final String plainCreds = JS_USERNAME+":"+JS_PASSWORD;
    byte[] plainCredsBytes = plainCreds.getBytes();
    byte[] base64CredsBytes = Base64.encodeBase64(plainCredsBytes);
    String base64Creds = new String(base64CredsBytes);

    HttpHeaders headers = new HttpHeaders();
    headers.add("Authorization", "Basic " + base64Creds);

    final String url = JS_RABBIT_URL;
    RestTemplate restTemplate = new RestTemplate();

    HttpEntity<String> request = new HttpEntity<String>(headers);
    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, request, String.class);
    String result = response.getBody();

    Assert.assertEquals("[\"rm-adapter\",\"jobsvc-adapter\",\"adapter-jobSvc\",\"adapter-rm\"]",result);

  }

  @Given("^Check Tmoblie is running$")
  public void checkTmobileRunning() throws Exception {

    final String plainCreds = TM_USERNAME + ":" + TM_PASSWORD;
    byte[] plainCredsBytes = plainCreds.getBytes();
    byte[] base64CredsBytes = Base64.encodeBase64(plainCredsBytes);
    String base64Creds = new String(base64CredsBytes);

    HttpHeaders headers = new HttpHeaders();
    headers.add("Authorization", "Basic " + base64Creds);
    final String url = TM_URL;
    RestTemplate restTemplate = new RestTemplate();
    HttpEntity<String> request = new HttpEntity<String>(headers);
    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, request, String.class);
    HttpStatus result = response.getStatusCode();

    Assert.assertEquals(result, HttpStatus.OK);
  }
}