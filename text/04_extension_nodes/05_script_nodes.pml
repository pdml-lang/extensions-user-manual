[ch (id=script_nodes) [title Script Nodes]

    [ch [title Introduction]

        A [i script node] enables you to embed executable source code in a PDML document.
        The source code is executed when the document is parsed.
        This allows you for example to:
        [list
            [el generate or update parts of the document programmatically]
            [el conditionally include/exclude text]
            [el retrieve text and data to be included in the document from external resources like files, URLs, databases, webservices, etc.]
            [el run external programs or OS scripts to get real-time data, generate media pointed to in the document, and much much more.]
        ]

        [note
            If you are a programmer, you can conceptually think of [i script nodes] as a very powerful preprocessor, because you can use the full features of a programming language.
            
            For example you can use self-defined or imported functions, external libraries, or call external programs (written in any programming language) or OS scripts to achieve whatever you need in your specific context.
        ]

        Script nodes are all associated with the predefined namespace prefix [c s] ([b [i s]]cripting).
        You can also think of the [c s] as an abbreviation for [b [i s]]ource code.

        PDML currently supports Javascript as scripting language.
        Support for other scripting languages might be added in the future.
    ]

    [ch [title Overview]

        There are three kinds of script nodes:
        [list
            [el
                [c s:exp]: evaluate an expression and insert its result into the PDML document
            ]
            [el
                [c s:script]: run a set of instructions to insert text, retrieve and transform text from external resources, create images files, or do anything else that can be achieved by executing a script
            ]
            [el
                [c s:def]: define constants, variables, and functions to be used in [c s:exp] and [c s:script] nodes
            ]
        ]

        A typical PDML document would first have one or more [c s:def] nodes to define shared code (constants and functions), and then some [c s:exp] and/or [c s:script] nodes to do whatever needs to be automated.
    ]

    [ch [title Nodes]

        [ch (id=expression_node) [title Expression Node]

            Here is an example of an [i expression node] used in a document:
            [code
                1 + 1 = [s:exp 1 + 1]
            code]
            This snippet results in:
            [code
                1 + 1 = 2
            code]

            Ok, that's not very spectacular!
            However, as we'll see later, the power of expressions quickly becomes obvious if we consider that [i any] valid Javascript expression can be used, including complex expressions that compose internal and/or external functions defined somewhere else.

            Now let's look at how this works.

            First, the [c \[\]] pair tells us that we are using a PDML node:
            [code
                [s:exp 1 + 1]
                ^           ^
            code]

            The namespace [c s] states that we are using an extension node in the [b [i s]]cripting category:
            [code
                [s:exp 1 + 1]
                 ^
            code]

            The node's name is [c exp], which is an abbreviation for [i [b exp]ression]:
            [code
                [s:exp 1 + 1]
                   ^^^
            code]

            Finally we can see that the node's content is the text [c 1 + 1]:
            [code
                [s:exp 1 + 1]
                       ^^^^^
            code]

            As soon as the parser sees the [c s:], it passes control to PDML's [i extension node handler]. This handler checks the node's name and namespace, and passes control to a dedicated handler for expressions. The expression handler reads the node's text content, evaluates it, converts it to a string, and then inserts the result (2 in our case) into the PDML document. The final result will be that the code:
            [code
                [s:exp 1 + 1]
            code]
            ... has been replaced with:
            [code
                2
            code]

            Hence, the application that reads the PDML document will see the following code:
            [code
                1 + 1 = [s:exp 1 + 1]
            code]
            ... like this:
            [code 1 + 1 = [s:exp 1 + 1]]

            [note
                In the world of pre-processors using macros we would say that [c \[s:exp 1 + 1\]] [i expands to] [c 2].
            ]

            Real-world examples demonstrating the power of expressions can be found in [link url=[u:get pdml_docs_extensions_url]scripting_examples/index.html text="Scripting Examples"].
        ]
    
        [ch (id=script_node) [title Script Node]

            A [c s:script] node contains one or more Javascript statements. Here is an example:
            [code
                [s:script doc.insert ( "Hello" );]
            code]
            
            This code insert the text [c Hello] in the document, so that the result of parsing the above code will be:
            [code
                Hello
            code]

            Yes, we could as well just have written [c Hello] in the document. So let's look at a more compelling example:
            [insert_code file=[u:get examples_dir]license_file/license_file_script.txt]

            This code checks if file [c resources/license.txt] exists.
            If it exists, its content is written into the PDML document.
            If it doesn't exist, a warning is written to the operating system's standard error device [c stderr] (e.g. the terminal).

            Note the [c ~~~] delimiters that embed the script.
            We'll soon see how this works.

            Note for programmers: You can think of a [c script] node as the body of a function that has no input arguments and doesn't return a value.
            Hence, a script is executed for its side effects (such as inserting code into the document).

            [-
                More examples can be found in [link url= text=Examples]
            -]
        ]

        [ch (id=definition_node) [title Definition Node]

            A [i definition] node has the qualified name [c s:def].
            It is used to define constants, variables, and functions that will later be used in [c s:exp] or [c s:script] nodes.
            
            [c s:def] nodes must be declared before using them in [c s:exp] or [c s:script] nodes.
            
            A single document can have any number of [c s:def] nodes.
            
            Here is a simple example of an [c s:def] node that defines the constant [c PI], as well as functions to compute the circumference and area of a circle:
            [insert_code file=[u:get examples_dir]circle/circle_library.def]

            Suppose the above code is in a [link url=https://www.pml-lang.dev/ text=PML] document, and later in the document we write:
            [code
                Consider a circle of radius 10 cm.
                
                It's [i circumference] is [s:exp computeCircumference ( 10 );] cm.
                
                It's [i area] is [s:exp computeArea ( 10 );] cm[sup 2].
            code]
            
            This code would expand to:
            [code
                Consider a circle of radius 10 cm.

                It's [i circumference] is 62.831852 cm.

                It's [i area] is 314.15926 cm[sup 2].
            code]
            ... and, after converting to HTML, be displayed as:
            [div
                Consider a circle of radius 10 cm.

                It's [i circumference] is 62.831852 cm.

                It's [i area] is 314.15926 cm[sup 2].
            ]

            Instead of embedding definition nodes in a document (as shown above) you can also import definition nodes from external resources.
            This is useful if you need the same set of functions in different documents, or if you want to share them with other users, for example via Github or Gitlab.

            Definitions can be imported with an [link url=[u:get pdml_docs_extensions_url]reference_manual/index.html#ins-file_node text=u:ins-file] node, or any other method that inserts text into a document.

            For example, you can store the above definition node in file [c circle_library.def] (the file name and extension can be chosen freely).
            The file looks like this:

            [caption File circle_library.def]
            [insert_code file=[u:get examples_dir]circle/circle_library.def]

            Here is an example of a fully functioning [link url=https://www.pml-lang.dev/ text=PML] file that uses a [c u:ins-file] node to import the definitions:
            [caption File circle_demo.pml]
            [insert_code file=[u:get examples_dir]circle/circle_demo.pml]

            If PML is installed on your computer you can convert the above PML file to HTML by executing the following command in a terminal:
            [input
                pmlc circle_demo.pml
            input]

            This command creates file [c output/circle_demo.html] which is displayed as follows in a browser:
            [image source=images/circle_demo.png]
        ]
    ]

    [ch (id=script_nodes_syntax) [title Syntax]

        All script nodes ([c s:exp], [c s:script], and [c s:def]) are of type [link url=[u:get pdml_ext_ref_manual_url]#raw-text text=raw-text].
        This means that an expression node with content [c list\[1\]] could be written in three ways:
        [list
            [el
                [code
                    [s:exp list\[1\]]
                code]
            ]

            [el
                [code
                    [s:exp
                        ~~~
                        list[1]
                        ~~~
                    ]
                code]
            ]

            [el
                [code
                    [s:exp
                        list[1]
                    exp]
                code]
            ]
        ]

        Note that the [c \[] and [c \]] characters must be escaped in the first version, but not in the other two.

        For more information about the syntax rules, please refer to [link url=[u:get pdml_ext_ref_manual_url]#raw-text text=raw-text]
    ]

    [ch (id=javascript_support) [title Javascript Support]

        The power of script nodes largely depends on the set of ready-to-use functions provided by existing libraries.
        Moreover, we must be able to define our own customized functions, and it should be easy to share them with other users who need the same functionality.

        In chapter [xref node_id=definition_node] we saw already how to define functions in a PDML document or import them from external resources.

        In this chapter we'll see how to use other existing functions/libraries.

        [ch [title Standard Libraries]

            [i Standard libraries] contain functions that are implicitly available.

            [ch [title Javascript Functions]

                PDML currently uses a Javascript implementation that is fully compatible with the [link url=https://262.ecma-international.org/12.0/ text="ECMAScript 2021 specification"].
                All objects and functions defined in the ECMAScript specification can therefore be used in PDML.
                
                For example you can use functions [link url="https://262.ecma-international.org/12.0/#sec-string.prototype.substring" text=substring], [link url="https://262.ecma-international.org/12.0/#sec-string.prototype.replaceall" text=replaceall], and many more when working with strings.
            ]

            [ch [title PDML Functions]
                
                PDML provides a set of global objects available in all PDML script nodes.
                Each object contains a set of functions and/or constants, logically grouped into categories by the object's name.
                The goal of this library is to provide additional functionality not available in 'standard' Javascript, but commonly required in PDML script nodes, such as working with files or interacting with the operating system.
                The API is designed to simplify common PDML scripting tasks as far as possible.
                For example:
                [list
                    [el
                        Object [link url=[u:get pdml_ext_ref_manual_url]#fileUtils text=fileUtils] contains functions to work with files, such as function [link url=[u:get pdml_ext_ref_manual_url]#fileUtils-readText text=readText] and [link url=[u:get pdml_ext_ref_manual_url]#fileUtils-writeText text=writeText] to read from or write to a text file.
                    ]
                    [el
                        Object [link url=[u:get pdml_ext_ref_manual_url]#OSCommand text=OSCommand] contains functions to execute OS commands. Command line arguments can be provided, and the data written to the OS's standard output device (stdout) can be retrieved into a string variable or constant.
                    ]
                ]

                The API is documented in chapter [link url=[u:get pdml_ext_ref_manual_url]#scripting_api text="Scripting API"] of the [link url=[u:get pdml_ext_ref_manual_url] text="PDML Extensions Reference Manual"].
            ]

            [- TODO
                [ch [title Java Functions]
                ]
            -]
        ]

        [ch [title External Libraries]

            [i External libraries] need to be explicitly loaded before their functions can be used.

            [ch [title ECMAScript Modules]

                Modules as defined by ECMAScript 6 and later are supported.
                [- TODO show example -]
            ]

            [ch [title PDML Definitions]

                As shown in chapter [xref node_id=definition_node], [c s:def] nodes can be imported from external resources.
            ]

            [ch [title Node.js Modules]

                While ECMAScript modules are supported, CommonJS modules can currently not be imported with function [c require(...)].

                Native support for Node.js modules might be added in a future version.

                However, non-native CommonJS modules can be bundled into self-contained Javascript source code files, and then be used in PDML.

                Moreover, if Node.js is installed, all NPM modules (including native ones like [c fs], [c http], etc.) can be used by executing Node.js like any other external program with functions available in [link url=[u:get pdml_ext_ref_manual_url]#OSCommand text=OSCommand].
            ]
        ]
    ]

    [ch [title Error handling]

        Errors in script nodes are detected and reported when the PDML document is parsed, and the code is executed.
    ]

    [ch [title Examples]

        Examples of script nodes can be found in [link url=[u:get pdml_docs_extensions_url]scripting_examples/index.html text="PDML Scripting Examples"].
    ]
]
