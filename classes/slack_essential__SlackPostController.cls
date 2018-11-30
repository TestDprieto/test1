/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/slack/*')
global class SlackPostController {
    global SlackPostController() {

    }
    @HttpPost
    global static void relayMessage(String token, String team_id, String team_domain, String channel_id, String channel_name, String user_id, String user_name, String command, String text, String response_url) {

    }
}
