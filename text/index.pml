[doc [title PDML Extensions User Manual]

    [div
        [table
[-
            [tr [tc [b PDML Version]][tc 1.0.0]]
-]
            [tr [tc [b First Published]][tc 2022-02-08]]
            [tr [tc [b Latest Update]][tc 2022-02-08]]
            [tr [tc [b License]][tc [link url=https://creativecommons.org/licenses/by-nd/4.0/ text="CC BY-ND 4.0"]]]
            [tr [tc [b Author and Copyright]][tc Christian Neumanns]]
            [tr [tc [b Website]][tc [link url=https://pdml-lang.github.io/ text="https://pdml-lang.github.io/"]]]
            [tr [tc [b PML Markup Code]][tc TODO]]
        ]
    ]

    [!set pdml_website_url=https://pdml-lang.github.io/]
    [!set pdml_docs_url=[!get pdml_website_url]docs/]
    [!set pdml_docs_extensions_url=[!get pdml_docs_url]extensions/]
    [!set pdml_ext_ref_manual_url=[!get pdml_docs_extensions_url]reference_manual/index.html]

    [!set examples_dir=input/examples/]

    [!ins-file path=01_introduction.pml]
    [!ins-file path=02_syntax_extensions/index.pml]
    [!ins-file path=03_parser_extensions/index.pml]
    [!ins-file path=04_action_nodes/index.pml]
    [!ins-file path=05_PDML_XML_bridge/index.pml]
[-
    [!ins-file path=06_history.pml]
-]
]
