package main

import (
    "fmt"
    "os"
)

func main() {
    fmt.Println("launcher stub")
    fmt.Println("image:", os.Getenv("IMAGE"))
    fmt.Println("workspace:", os.Getenv("WORKSPACE"))
    fmt.Println("port:", os.Getenv("PORT"))
}