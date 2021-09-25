const evenword = S => {
	var letter_counter = {};
	S.split('').forEach(function(s) {
	    letter_counter[s] ? letter_counter[s]++ : letter_counter[s] = 1;
	});
	return Object.values(letter_counter).filter(letter => letter%2==1).length
}
