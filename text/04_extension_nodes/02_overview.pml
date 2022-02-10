[ch [title Overview]

    While PDML [i data nodes] simply represent [b data], [i extension nodes] add [b behavior] to a PDML document.
    You can also think of an extension node as an [i action node] that [b does] something.
    
    The behavior of an extension node depends on its name, and is implemented in PDML.
    An extension node can have attributes to customize it's behavior.

    PDML specifies a set of standard extension nodes with well-defined names, attributes and behavior.
    Other extension nodes can programmatically be added to implement customized, domain-dependant actions.

    To avoid name clashes with data nodes, extension nodes are all associated with predefined namespaces. 

    There are three categories of extension nodes, and each category is associated with a different namespace:
    [list
        [el
            [header Utility Nodes]
            These extension nodes provide various features and utilities.
        ]

        [el
            [header Type Nodes]
            Extension nodes in this category define data types (string, number, boolean, etc).
            They are used to parse, validate and transform data nodes.
        ]

        [el
            [header Script Nodes]
            Script nodes contain user-defined source code that is executed when the PDML document is parsed.
        ]
    ]

    [note
        If you are a programmer, you can conceptually think of an extension node as a function.
        
        The node's name is the name of the function.
        
        The node's attributes and its content are the function's input arguments.
        
        The function's body is implemented in PDML (or in a plugin in case of a customized extension node).
        
        The function returns a result and/or produces a side effect.
    ]

    [-
        [note
            Extension nodes are not supported in [link url=TODO text="Basic PDML"]. They are part of PDML's [i extensions].
        ]
    -]

    Now that we have covered the therory, let's get practical and see which extension nodes exist and what they do.
]
