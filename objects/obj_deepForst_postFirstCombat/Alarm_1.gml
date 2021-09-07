/// @description Post combat first textbox

if (global.run == true) {
	createDefaultNamedTextbox(["Huh... I mean you're at least good at escaping a fight...",
	"...",
	"We'll be fine. If anything I'll be there to make sure you don't get yourself into any trouble.",
	"Still, if at any point you need a quick refresher on fighting, here's a manual for you."], self,
	["Himiko", "Teal", "Himiko", "Himiko"]);
} else {
	createDefaultNamedTextbox(["That went well. Looks like you should be fine if we head deeper in.",
	"If anything I'll be there to make sure you don't get yourself into any trouble.",
	"Still, if at any point you need a quick refresher on fighting, here's a manual for you."], self,
	["Himiko", "Himiko", "Himiko"]);
}