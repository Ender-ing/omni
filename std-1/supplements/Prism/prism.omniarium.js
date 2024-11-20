Prism.languages.omniarium = {
    'comment': [
        {
            pattern: /;;\?[\s\S]*?(?:\?;;|$)/,
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
        pattern: /(#[\w]+)\b/
    },
    "variable": {
        pattern: /\b([a-z][\w]*)\b/
    },
    "type": {
        pattern: /\b([A-Z][\w]*)\b/
    },
    "number": {
        pattern: /-?((\d+\.\d*([eE][-+]?\d+)?)|(\d*\.\d+([eE][-+]?\d+)?)|(\d+([eE][-+]?\d+)?))/,
        greedy: true
    },
    "string": [
        {
            pattern: /"(?:\\.|[^"\\])*("?)/,
            greedy: true
        },
        {
            pattern: /`(?:\\.|[^`\\])*(`?)/,
            greedy: true
        },
        {
            pattern: /'[^\n]*?('|\n)/,
            greedy: true
        }
    ]
};
