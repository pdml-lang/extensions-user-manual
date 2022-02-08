[ch [title Introduction]

    A normal PDML [i data] node looks like this:
    [code
        [name ...]
    code]

    An [i action] node looks like a data node, except that it's name is preceded by an exclamation point ([c !]):
    [code
        [!name ...]
         ^
    code]

    While PDML data nodes simply represent [i data], action nodes add [i behavior] to a PDML document.
    As hinted by its name, an action node [i does] something.
    
    The behavior of an action node depends on its name, and is implemented in PDML.
    An action node can have attributes to customize it's behavior.

    [note
        If you are a programmer, you can conceptually think of an action node as a function.
        
        The node's name is the name of the function.
        
        The node's attributes and its content are the function's input arguments.
        
        The function's body is implemented in PDML.
        
        The function returns a result and/or produces a side effect.
    ]

    PDML specifies a set of standard action nodes with well-defined names, attributes and behavior.
    Other action nodes can programmatically be added to implement customized, domain-dependant actions.

    Data nodes and action nodes with the same name can peacefully co-exist.
    The [c !] before a name classifies a node as an action node.
    Hence [c \[foo ...\]] denotes a normal data node, while [c \[!foo ...\]] denotes an action node.

    There are three categories of action nodes:
    [list
        [el
            [header Utility Nodes]
            These action nodes provide various features and utilities.
        ]

        [el
            [header Type Nodes]
            Action nodes in this category define data types (string, number, boolean, etc).
            They are used to parse, validate and transform data nodes.
        ]

        [el
            [header Script Nodes]
            Script nodes contain user-defined source code that is executed when the PDML document is parsed.
        ]
    ]

    [-
        [note
            Action nodes are not supported in [link url=TODO text="Basic PDML"]. They are part of PDML's [i extensions].
        ]
    -]

    Now that we have covered the therory, let's get practical and see which action nodes exist and what they do.
]
