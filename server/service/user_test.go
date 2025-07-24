package service

import (
	"context"
	"server/model"
	"testing"
)

func TestCreateUser(t *testing.T) {
	service := NewUserService(model.NewMockUserRepo())

	user, err := service.CreateUser(context.Background(), "Alice", "password123")
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
	if user.Username != "Alice" {
		t.Fatalf("expected username Alice, got %s", user.Username)
	}

	_, err = service.CreateUser(context.Background(), "fail", "password123")
	if err == nil {
		t.Fatalf("expected error, got nil")
	}
}
