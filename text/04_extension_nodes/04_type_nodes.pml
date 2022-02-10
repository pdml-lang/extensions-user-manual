[ch (id=type_nodes) [title Type Nodes]

    Type nodes denote data types.

    They are all associated with the predefined namespace prefix [c t] ([b [i t]]ype).

    Type nodes are used to parse, validate, and optionally transform data nodes.

    [note
        If you are a programmer you can conceptually think of PDML types as types in a programming language (string, number, boolean, etc.).
    ]

    To understand why types are useful, consider a PDML document containing data about employees.
    Each [c employee] node contains child-node [c birthdate]:
    [code
        [employee
            ...
            [birthdate 1999-12-31]
            ...
        ]
    code]
    
    Without types, the PDML parser has no way of checking and reporting invalid [c birthdate] nodes like this one: [c \[birthdate kdjhfgkjdf\]].
    The burden to validate birthdates is left to the application that consumes the parser's output.
    
    A PDML [i type] enables the parser to [i validate] data nodes.
    To accomplish this, a type must be assigned to a data node.

    In our example we need to assign [i type] [c date] to node [c birthdate].
    There are different ways to do this:

    [list
        [el [header Inline type]

            In this case, a data node contains a type node that contains the data:
            [code
                [birthdate [t:date 1999-12-31]]
                           ^^^^^^^           ^
            code]
            Now the parser ensures that the content of [c t:date] is a valid date.
            It will generate an error if the node's content is invalid.

            The application reading the parser's output will only see a node [c birthdate] with text content [c 1999-12-31], as if the document simply contained:
            [code
                [birthdate 1999-12-31]
            code]
            The advantage is that the application doesn't need to check the content of [c birthdate] anymore.
            [c birthdate] is guaranteed to contain a valid date.

            [note
                The application still gets a [c string] that might need to be parsed into the correct object type of the application's programming language.
                
                For example, if the application is written in Java, the parser will provide a [c String] object representing a valid date, which the application converts into a [c java.time.LocalDate] object.
            ]

            Note that inline types are used rarely, because each individual node needs to have a type annotation.
        ]

        [el [header Configuration by node name]

            A more practical approach is to assign a specific type to all nodes with a specific name (e.g. all nodes with name [c N] are of type [c T]).
            
            This can be done programmatically by configuring the parser.
            
            In our employees example, the parser would be told that all nodes with name [c birthdate] are of type [c date].
            Therefore the document doesn't need inline type annotations anymore.
            A birthdate node looks like this:
            [code
                [birthdate 1999-12-31]
            code]
            ... but the parser checks that all [c birthdate] nodes contain valid dates.
        ]

        [el [header Schema]

            [note PDML schemas are not specified and not implemented yet.]

            A schema is itself a PDML document that assigns types to data nodes.
            It can also define new domain-specific types, based on standard PDML types.
            A schema can be:
            [list
                [el [b embedded]: Schema and data nodes are stored in the same document. The schema must be defined at the beginning of the document.]
                [el [b external]: Schema and data are stored in different documents. The data document contains a reference to the schema's location.]
            ]
        ]
    ]

    The full list of PDML types is documented in chapter [link url=[u:get pdml_docs_extensions_url]reference_manual/index.html#types text=Types] of the reference manual.

    [note
        PDML types are a work-in-progress.
        A future PDML version might have support for adding domain-specific types programmatically or by sharable configuration data.
    ]
]
