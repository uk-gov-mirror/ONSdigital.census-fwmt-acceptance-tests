package uk.gov.ons.census.fwmt.data.dto.rm;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "id"
})
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CollectionCase {

  @JsonProperty("id")
  private String id;

  @JsonIgnore
  private Map<String, Object> additionalProperties = new HashMap<>();
}