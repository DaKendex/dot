// main_test.go
package main

import (
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestDadJokeAPI(t *testing.T) {
	mockJoke := Joke{
		ID:     "xyz123",
		JOKE:   "I'm afraid for the calendar. Its days are numbered.",
		STATUS: 200,
	}

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(mockJoke)
	})

	server := httptest.NewServer(handler)
	defer server.Close()

	req, err := http.NewRequest("GET", server.URL, nil)
	if err != nil {
		t.Fatalf("failed to create request: %v", err)
	}
	req.Header.Set("Accept", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		t.Fatalf("failed to make request: %v", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		t.Fatalf("failed to read response body: %v", err)
	}

	var joke Joke
	if err := json.Unmarshal(body, &joke); err != nil {
		t.Fatalf("failed to unmarshal response: %v", err)
	}

	if joke.JOKE != mockJoke.JOKE {
		t.Errorf("expected joke %q, got %q", mockJoke.JOKE, joke.JOKE)
	}
}
