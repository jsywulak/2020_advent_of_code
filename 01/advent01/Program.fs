open System
open System.IO

let readLines (filePath:string) = seq {
    use sr = new StreamReader (filePath)
    while not sr.EndOfStream do
        yield sr.ReadLine ()
}

let asInt : string -> int = int

[<EntryPoint>]
let main argv =
    let lines = readLines "../input.txt"
    let diffs = 
        lines
        |> Seq.map (fun x -> 2020 - asInt x)

    printfn "%A" diffs
    0 // return an integer exit code