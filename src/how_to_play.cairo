use serde_json::json;

fn how_to_play_json() -> serde_json::Value {
    let playinfo = json!({
        "info"
    });
    playinfo
}