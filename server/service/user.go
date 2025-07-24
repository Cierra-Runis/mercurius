package service

import (
	"context"
	"errors"
	"server/model"
	"time"

	"golang.org/x/crypto/bcrypt"
)

const (
	ErrUsernameTaken   = "username already taken"
	ErrInvalidPassword = "invalid password"
	ErrUserNotFound    = "user not found"
)

type UserService struct {
	repo model.UserRepository
}

func NewUserService(repo model.UserRepository) *UserService {
	return &UserService{repo: repo}
}

func (s *UserService) CreateUser(ctx context.Context, username string, password string) (*model.User, error) {
	_, err := s.repo.GetUserByUsername(ctx, username)
	if err == nil {
		return nil, errors.New(ErrUsernameTaken)
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, errors.New(ErrInvalidPassword)
	}

	user := &model.User{
		Username:  username,
		Nickname:  username, // Default nickname is the same as username
		Password:  string(hashedPassword),
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	return s.repo.CreateUser(ctx, user)
}

func (s *UserService) AuthenticateUser(ctx context.Context, username string, password string) (*string, error) {
	user, err := s.repo.GetUserByUsername(ctx, username)
	if err != nil {
		return nil, errors.New(ErrUserNotFound)
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password)); err != nil {
		return nil, errors.New(ErrInvalidPassword)
	}

	token, err := user.GenerateToken()
	if err != nil {
		return nil, err
	}
	return &token, nil
}
