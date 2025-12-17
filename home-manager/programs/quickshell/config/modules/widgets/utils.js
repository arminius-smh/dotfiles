function getAnyText(node) {
    let name = "";
    if (node.nickname != "") {
        name = node.nickname;
    } else if (node.description != "") {
        name = node.description;
    } else if (node.name != "") {
        name = node.name;
    } else {
        name = "Unknown";
    }
    return name;
}
