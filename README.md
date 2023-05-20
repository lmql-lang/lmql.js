# lmql.js 

This is a simple, experimental JS wrapper to run a distribution of LMQL in the browser.

## Usage

To use this library, you first need to clone and build the LMQL project.

```bash
git submodule update --init --recursive
```

Then we create a web build of LMQL, resulting in files `js/lmql.web.min.js` and `js/wheels`. Note that for this process you need the `yarn` package manager.

```bash
bash web-build.sh
```

Now you can use the library in your own project, as demonstrated in `js/lmql.js` and `index.html`. For now, this wrapper simply invokes the LMQL playground interpreter, which will emit a lot of debug output to the console. 

This setup runs `js/lmql.web.min.js` in a web worker, which uses [Pyodide](https://pyodide.org/en/stable/) to run the LMQL runtime within a WebAssembly Python interpreter. The `js/wheels` directory contains the Python packages required by LMQL, which are automatically loaded by `js/lmql.web.min.js`.

On the client side, some light interfacing with the LMQL worker process has to be done, as implemented in `js/lmql.js`.

## TODO

To implement a more lightweight interface, the plan is to adapt `lmql/web/browser-build/src/lmql-worker.js` and `js/lmql.js` to internally use `lmql.run(...)` with a corresponding output writer, instead of the playground interpreter.

## Current Limitations

* The web build currently only support OpenAI models as accessible via the OpenAI API

* The web build relies on a slower (python-only) tokenizer (https://github.com/alisonjf/gpt3-tokenizer), which is not comparable in performance/stability to the `main` branch tokenizer `tiktoken`, which has yet to be ported to WebAssembly/Pyodide environments.

* The web runtime of LMQL can be noticibly slower than the native/non-webassembly runtime, due to the overhead of Pyodide and inter-worker communication.

* The web runtime has some startup time, as the Pyodide/Python interpreter and dependencies are installed and loaded in the worker process.