[ch [title Utility Nodes]

    Utility nodes provide various practical features and utilities.

    For example:
    [list
        [el
            A [c !set] node assigns a text to a named parameter, and subsequent [c !get] nodes can be used to insert the same text multiple times into the PDML document.
            This supports the important [link url=https://en.wikipedia.org/wiki/Don%27t_repeat_yourself text="Don't repeat yourself (DRY)"] principle.
        ]

        [el
            An [c !ins-file] node reads a text file and inserts the text into the PDML document.

            [- TODO?
                Here is an example of the main file of an article written in [link url=TODO text=PML]:
                [code
                code]
            -]
        ]
    ]

    The full list of utility nodes is documented in chapter [link url=[!get pdml_docs_extensions_url]reference_manual/index.html#utility_nodes text="Utility Nodes"] of the reference manual.
]
