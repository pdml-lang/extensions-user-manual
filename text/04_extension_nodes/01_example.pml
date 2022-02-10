[ch [title Preliminary Example]

    To get the gist of extension nodes, let's have a look at the following example of an extension node:
    [code
        [u:ins-file path=chapter.txt]
    code]

    This node looks like a normal data node with name [c ins-file], namespace [c u], and an attribute [c path] with value [c chapter.txt].
    However, the difference between a normal [i data] node and an [i extension] node is that an extension node represents an [i instruction to do something].

    In the above example, PDML is instructed to insert the content of file [c chapter.txt] into the PDML document.
]
