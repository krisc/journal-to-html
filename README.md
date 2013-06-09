These two scripts work together to create a journal/diary system. Move both scripts to your ~/bin/ directory. This automates opening of text files (with the filename journal-yyyymmdd) in your favorite editor. The ruby script then converts these text files into navigatable html files.

##Usage:

Make journal exectuable:

```bash
chmod +x journal
```

To open a new journal text file:

```bash
journal
```

To convert your journal files into html and open in the browser:

```bash
journal read
```
