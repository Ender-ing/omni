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
    ],
    "function": {
        pattern: /(\$[\w]+)\b/
    },
    "constant": {
        pattern: /\b(_[\w]+)\b/
    },
    "variable": {
        pattern: /\b([a-z][\w]*)\b/
    },
    "type": {
        pattern: /\b([A-Z][\w]*)\b/
    }
};
