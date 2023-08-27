from google.protobuf.empty_pb2 import Empty  # type: ignore
from grpc_common.protobuf.user import user_pb2 as user_message
from grpc_common.protobuf.user import user_pb2_grpc as user_service


class UserServicer(user_service.UserServicer):

    def logout_user(self, request: user_message.LogoutUserRequest,
                    context: grpc.ServicerContext) -> Empty:
        pass

    def login_user(self, request: user_message.LoginUserRequest,
                   context: grpc.ServicerContext) -> user_message.LoginUserResult:
        pass

    def create_user(self, request: user_message.CreateUserRequest,
                    context: grpc.ServicerContext) -> Empty:
        pass

    def delete_user(self, request: user_message.DeleteUserRequest,
                    context: grpc.ServicerContext) -> Empty:
        pass

    def check_user_login(self, request: user_message.LogoutUserRequest,
                         context: grpc.ServicerContext) -> user_message.CheckLoginResult:
        pass