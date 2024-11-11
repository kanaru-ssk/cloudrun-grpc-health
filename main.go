package main

import (
	"context"
	"fmt"
	"log"
	"net"

	"github.com/sethvargo/go-envconfig"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"
	"google.golang.org/grpc/reflection"
)

type EnvConfig struct {
	Port int `env:"PORT,default=50051"`
}

func main() {
	ctx := context.Background()

	var envConfig EnvConfig
	if err := envconfig.Process(ctx, &envConfig); err != nil {
		log.Fatalf("failed to get env: %v", err)
	}

	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", envConfig.Port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	reflection.Register(s)

	healthSrv := health.NewServer()
	healthpb.RegisterHealthServer(s, healthSrv)
	healthSrv.SetServingStatus("mygrpc", healthpb.HealthCheckResponse_SERVING)

	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
