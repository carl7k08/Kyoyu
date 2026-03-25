const input = document.getElementById("input");
const button = document.getElementById("btn");
const messages = document.getElementById("messages");

button.onclick = function () {
    if (input.value !== "") {
        const p = document.createElement("p");
        p.textContent = input.value;
        messages.appendChild(p);
        input.value = "";
    }
};