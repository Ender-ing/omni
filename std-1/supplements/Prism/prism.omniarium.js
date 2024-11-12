Prism.languages.omniarium = {
    'comment': [
		{
			pattern: /;;;[\s\S]*?(?:;;;|$)/,
			greedy: true
		},
		{
			pattern: /;;.*/,
			greedy: true
		}
	]
};
