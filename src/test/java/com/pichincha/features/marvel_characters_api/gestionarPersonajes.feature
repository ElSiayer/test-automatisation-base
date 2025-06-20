@REQ_HU-PRACTICA @HUPRACTICA @marvel_characters_management @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: HU-PRACTICA Gestión de personajes de Marvel (microservicio para administrar personajes de Marvel)

  Background:
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'testuser'
    * url baseUrl
    * path username, 'api/characters'
    # * def id1 = '1'
    # * def id2 = '2'

  @id:1 @obtenerPersonajes @listadoExitoso200
  Scenario: T-API-HU-PRACTICA-CA01-Obtener todos los personajes exitosamente 200 - karate
    When method GET
    Then status 200
    # And match response != null
    # And match response == '#array'

  @id:2 @obtenerPersonaje @detalleExitoso200
  Scenario: T-API-HU-PRACTICA-CA02-Obtener personaje por ID exitosamente 200 - karate
    * def characterId = '109'
    * path characterId
    When method GET
    Then status 200
    # And match response != null
    # And match response contains { id: '#number', name: '#string', alterego: '#string' }

  @id:3 @obtenerPersonaje @personajeNoExiste404
  Scenario: T-API-HU-PRACTICA-CA03-Obtener personaje inexistente 404 - karate
    * def characterId = '999'
    * path characterId
    When method GET
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: '#string' }

  @id:4 @crearPersonaje @creacionExitosa201
  Scenario: T-API-HU-PRACTICA-CA04-Crear personaje exitosamente 201 - karate
    * def requestData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set requestData.name = requestData.name + '15'
    And request requestData
    When method POST
    Then status 201
    # And match response.id == '#number'
    # And match response.name == requestData.name

  @id:5 @crearPersonaje @errorValidacion400
  Scenario: T-API-HU-PRACTICA-CA05-Crear personaje con datos inválidos 400 - karate
    * def requestData = read('classpath:data/marvel_characters_api/request_invalid_character.json')
    And request requestData
    When method POST
    Then status 400
    # And match response contains { name: '#string', alterego: '#string' }
    # And match response.name == 'Name is required'

  @id:6 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-HU-PRACTICA-CA06-Crear personaje con nombre duplicado 400 - karate
    * def requestData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request requestData
    When method POST
    Then status 400
    # And match response.error == 'Character name already exists'
    # And match response == { error: '#string' }

  @id:7 @actualizarPersonaje @actualizacionExitosa200
  Scenario: T-API-HU-PRACTICA-CA07-Actualizar personaje exitosamente 200 - karate
    * def characterId = '189'
    * path characterId
    * def requestData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set requestData.description = 'Updated description'
    And request requestData
    When method PUT
    Then status 200
    # And match response.description == 'Updated description'
    # And match response.id == characterId

  @id:8 @actualizarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-PRACTICA-CA08-Actualizar personaje inexistente 404 - karate
    * def characterId = '999'
    * path characterId
    * def requestData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request requestData
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: '#string' }

  @id:9 @eliminarPersonaje @eliminacionExitosa204
  Scenario: T-API-HU-PRACTICA-CA09-Eliminar personaje exitosamente 204 - karate
    * def characterId = '90'
    * path characterId
    When method DELETE
    Then status 204

  @id:10 @eliminarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-PRACTICA-CA10-Eliminar personaje inexistente 404 - karate
    * def characterId = '999'
    * path characterId
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: '#string' }
